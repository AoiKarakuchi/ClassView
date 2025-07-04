class Classroom < ApplicationRecord
    #アソシエーションの設定
    has_many :subject_held_classrooms, foreign_key: :classroom_name, primary_key: :name
    has_many :subjects, through: :subject_held_classrooms
    validates :name, presence: :true
end
