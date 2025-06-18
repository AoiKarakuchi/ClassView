class Subject < ApplicationRecord
    #アソシエーションの設定
    has_many :user_regist_subjects, foreign_key: :subject_number, primary_key: :number
    has_many :subject_open_timetables, foreign_key: :subject_number, primary_key: :number
    has_many :subject_held_classrooms, foreign_key: :subject_number, primary_key: :number
    has_many :timetables, through: :subject_open_timetables
    validates :number, presence: true
    validates :name, presence: true
end
