# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# 科目
subjects = [
  { number: 'ABC101', name: '英語 I' },
  { number: 'DEF202', name: '線形代数学' },
  { number: 'GHI303', name: 'プログラミング入門' }
].map do |attrs|
  Subject.find_or_create_by(number: attrs[:number]) do |subject|
    subject.name = attrs[:name]
  end
end

# 時間割
timetables = [
  { semester: '春A', dayofweek: '月', hour: '1' },
  { semester: '春A', dayofweek: '月', hour: '2' },
  { semester: '春B', dayofweek: '火', hour: '1' }
].map do |attrs|
  Timetable.find_or_create_by(attrs)
end

# 科目と時間割の紐づけ
SubjectOpenTimetable.find_or_create_by(subject_number: 'ABC101', timetable_id: timetables[0].id)
SubjectOpenTimetable.find_or_create_by(subject_number: 'DEF202', timetable_id: timetables[1].id)
SubjectOpenTimetable.find_or_create_by(subject_number: 'GHI303', timetable_id: timetables[2].id)

