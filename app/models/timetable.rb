class Timetable < ApplicationRecord
    #アソシエーションの設定
    has_many :subject_open_timetables
    has_many :subjects, through: :subject_open_timetables  
    validates :semester, presence: true
    validates :dayofweek, presence: true, unless: -> { note.present? }
    validates :hour, presence: true, unless: -> { note.present? }

end
