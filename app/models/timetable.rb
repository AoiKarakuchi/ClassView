class Timetable < ApplicationRecord
    #アソシエーションの設定
    has_many :subject_open_timetables
    validates :semester, presence: true
    validates :dayofweek, presence: true
    validates :hour, presence: true
end
