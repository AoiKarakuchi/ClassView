class Classroom < ApplicationRecord
    #アソシエーションの設定
    has_many :subject_held_classrooms, foreign_key: :classroom_name, primary_key: :name
    validates :name, presence: :true
    validates :latitude, presence: :true
    validates :longitude, presence: :true
end
