class SubjectHeldClassroom < ApplicationRecord
    #アソシエーションの設定
    belongs_to :subject, foreign_key: :subject_number, primary_key: :number
    belongs_to :classroom, foreign_key: :classroom_name, primary_key: :name
end
