require 'csv'

class UserRegistSubject < ApplicationRecord
    def self.import(file, current_user)
        CSV.foreach(file.path, headers: false, encoding: 'UTF-8') do |row|
            subject_number = row[0].to_s.strip
            next if subject_number.blank?

            find_or_create_by!(
                user_email: current_user.email,
                subject_number: subject_number
            )
        end
    end

    #アソシエーションの設定
    belongs_to :user, foreign_key: :user_email, primary_key: :email
    belongs_to :subject, foreign_key: :subject_number, primary_key: :number
end
