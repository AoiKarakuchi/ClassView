class UserRegistSubject < ApplicationRecord
    #アソシエーションの設定
    belongs_to :user, foreign_key: :user_email, primary_key: :email
    belongs_to :subject, foreign_key: :subject_number, primary_key: :number
end
