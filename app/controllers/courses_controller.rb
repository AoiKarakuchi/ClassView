# 追加ファイル(学期変更)
class CoursesController < ApplicationController
  def by_term
    # home.html.erbのfetchで渡ってきたtermを受け取る
    semester = params[:term]

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
                            .where(subject_open_timetables: {subject_number: user_subject_numbers}, semester: semester)
      # 重複を取り除く
                            .distinct

      #詳しいデバッグ用ログ
      #debugger
      Rails.logger.debug "Timetables count: #{timetables.count}"
      Rails.logger.debug "Timetables semesters: #{timetables.pluck(:semester).uniq}"
      # home.html.erbに渡すデータ
      render json: timetables.map { |timetable|
        subjects = timetable.subjects.select { |s| user_subject_numbers.include?(s.number) }

        {
          semester: timetable.semester,
          subjects: subjects.map { |s| s.as_json(only: [:number, :name]) }
        }
      }

    rescue => e
      logger.error "Error fetching courses: #{e.message}"
      render json: { error: "データ取得中にエラーが発生しました" }, status: 500
    end
  end
end