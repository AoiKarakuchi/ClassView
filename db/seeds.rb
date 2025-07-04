# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'csv'

def expand_semesters(raw)
  return [] if raw.blank?

  # 複数の学期がカンマで区切られている場合に対応
  tokens = raw.split(',').map(&:strip)
  result = []

  tokens.each do |token|
    if token =~ /\A(春|秋)([A-C]+)\z/
      season = $1
      codes = $2.chars
      result.concat(codes.map { |code| "#{season}#{code}" })
    else
      result << token
    end
  end

  result
end

def parse_schedule(value)
  return [ { day_of_week: nil, period: nil, note: value } ] if value.blank?

  day_names = %w[日 月 火 水 木 金 土]
  result = []
  parts = value.split(',').map(&:strip)

  last_day = nil

  parts.each do |part|
    if part =~ /\A([#{day_names.join}])(\d+)\z/
      day = $1  # 例: "月"
      period = $2.to_s
      result << { day_of_week: day, period: period, note: nil }
      last_day = day

    elsif part =~ /\A\d+\z/ && last_day
      result << { day_of_week: last_day, period: part.to_s, note: nil }

    else
      result << { day_of_week: nil, period: nil, note: part }
      last_day = nil
    end
  end

  result
end

semesters = [ "春A", "春B", "春C", "秋A", "秋B", "秋C", "通年", "夏季休業中", "春季休業中" ]
times = [ "月", "火", "水", "木", "金", "土" ]
hours = [ "1", "2", "3", "4", "5", "6", "7", "8" ]
notes = [ "応談", "随時", "集中" ]
year = 2025

semesters.each do |s|
  times.each do |t|
    hours.each do |h|
      Timetable.create(
        semester: s,
        dayofweek: t,
        hour: h
      )
    end
  end
end

semesters.each do |s|
  notes.each do |n|
    Timetable.create(
      semester: s,
      note: n
    )
  end
end

CSV.foreach("db/subjects.csv", headers: true) do |row|
  subject_number = row["科目番号"].to_s.strip
  Subject.find_or_create_by(
    number: subject_number,
    name: row["科目名"].to_s
  )

  semesters = expand_semesters(row["実施学期"])

  if semesters.present?
    schedules = parse_schedule(row["曜時限"])

    semesters.each do |semester|
      schedules.each do |s|
        timetable = Timetable.find_by(
          semester: semester,
          dayofweek: s[:day_of_week],
          hour: s[:period],
          note: s[:note]
        )

        if timetable
          SubjectOpenTimetable.find_or_create_by(
            subject_number: subject_number,
            timetable_id: timetable.id,
            
            year: year
          )
        end
      end
    end
  end

  classrooms = row["教室"].to_s.split(',').map(&:strip)

  if classrooms.present?
    classrooms.each do |c|
      Classroom.find_or_create_by(
        name: c
      )

      SubjectHeldClassroom.find_or_create_by(
        subject_number: subject_number,
        classroom_name: c,
        year: year
      )
    end
  end
end

CSV.foreach("db/classrooms.csv", headers: true) do |row|
  name = row["教室"]
  latitude = row["緯度"]
  longitude = row["経度"]

  # 教室が存在しない場合のみ作成（重複防止）
  classroom = Classroom.find_or_initialize_by(name: name)
  classroom.latitude = latitude
  classroom.longitude = longitude
  classroom.save!

  puts "✅ 教室を作成しました: #{name}"
end
