class SubjectOpenTimetable < ApplicationRecord
    #アソシエーションの設定
    belongs_to :subject, foreign_key: :subject_number, primary_key: :number
    belongs_to :timetable
end
