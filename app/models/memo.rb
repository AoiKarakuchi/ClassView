class Memo < ApplicationRecord
  belongs_to :user, foreign_key: "user_email", primary_key: "email"
  validates :user_email, presence: true 
  validates :content, presence: true, length: { maximum: 300 }
end
