# 追加ファイル(学期変更)
class CoursesController < ApplicationController
  def by_term
    # home.html.erbのfetchで渡ってきたtermを受け取る
    semester = params[:term]
    year = params[:year].to_i
    # デバッグ用ログ
    Rails.logger.debug "Received semester: #{semester}"

    # エラーハンドリング
    begin
      # 主キーであるemailがログインしたアカウントと同じものを探してそのレコードを代入
      # current_user.emailがログインしたアカウントのemailを指す
      user=User.find_by(email: current_user.email)
      user_subject_numbers = user.subjects.pluck(:number)
      # Timetableとsubjectを結合
      timetables = Timetable.joins(:subject_open_timetables)
      # ログインしたアカウントの履修した授業番号と選択した学期を元に絞り込み
                            .where(subject_open_timetables: {subject_number: user_subject_numbers, year: year}, semester: semester)
      # 重複を取り除く
                            .distinct

      #詳しいデバッグ用ログ
      #debugger
      Rails.logger.debug "Timetables count: #{timetables.count}"
      Rails.logger.debug "Timetables semesters: #{timetables.pluck(:semester).uniq}"
      # home.html.erbに渡すデータ
      render json: timetables.flat_map { |timetable|
        timetable.subjects.select { |s| user_subject_numbers.include?(s.number) }.map do |subject|
          {
            semester: timetable.semester,
            dayofweek: timetable.dayofweek,
            hour: timetable.hour,
            note: timetable.note,
            subject: {
              number: subject.number,
              name: subject.name
            }
          }
        end
      }

    rescue => e
      logger.error "Error fetching courses: #{e.message}"
      render json: { error: "データ取得中にエラーが発生しました" }, status: 500
    end
  end

  #授業の削除
  def delete_subject
    semester = params[:term]
    subject_number = params[:number]

    begin
      user = User.find_by(email: current_user.email)

      deleted_count = UserRegistSubject
        .where(subject_number: subject_number)
        .delete_all

      render json: { success: true, deleted_count: deleted_count }
    rescue => e
      logger.error "Delete subject error: #{e.message}"
      render json: { success: false, error: e.message }, status: 500
    end
  end

end