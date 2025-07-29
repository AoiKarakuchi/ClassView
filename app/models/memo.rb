class Memo < ApplicationRecord
  belongs_to :user, foreign_key: "user_email", primary_key: "email"
  default_scope -> { order(created_at: :desc) }
  validates :user_email, presence: true 
  validates :content, presence: true, length: { maximum: 100 }
end
