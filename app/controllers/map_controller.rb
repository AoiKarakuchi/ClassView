# 追加ファイル(マップ反映)
require "date"
class MapController < ApplicationController
  def showMap
    # エラーハンドリング
    begin
      # 主キーであるemailがログインしたアカウントと同じものを探してそのレコードを代入
      # current_user.emailがログインしたアカウントのemailを指す
      user=current_user
      year= DateInfo.year
      semester= DateInfo.semester
      weekday= params[:youbi] || DateInfo.weekday
      Rails.logger.info "Year: #{year}, Semester: #{semester}, Weekday: #{weekday}"
      # 授業名とその教室の位置情報を検索
      classrooms=SubjectHeldClassroom.joins(:classroom)
      .joins(subject: { subject_open_timetables: :timetable })
      .select("subject_held_classrooms. *, timetables. *,subjects.name AS subject_name,
       classrooms.name AS classroom_name, classrooms.latitude, classrooms.longitude,
       subject_open_timetables.year")
      .where(subjects: { number: user.subjects.pluck(:number) })
      # 学期は適当に入れてます
      .where(subject_open_timetables: { year: year })
      .where(timetables: { semester: semester, dayofweek: weekday })
      .distinct

      # map.html.erbに渡すデータ
      grouped=classrooms.group_by(&:classroom_name)# 名前ごとにグループ化

      result= grouped.map do |classroom_name, records|
          subject = records.map(&:subject_name).uniq.join(", ")
          hour = records.map(&:hour).uniq
        {
          name: classroom_name,
          latitude: records.first.latitude,
          longitude: records.first.longitude,
          subject: subject,
          dayofweek: records.first.dayofweek,
          hour: hour
        }
      end
      # puts result.to_json
      render json: result
    rescue => e
      logger.error "Error fetching courses: #{e.message}"
      render json: { error: "データ取得中にエラーが発生しました" }, status: 500
    end
  end
end
