require 'csv'

class UserRegistSubject < ApplicationRecord
  class InvalidCSVError < StandardError; end

  def self.import(file, current_user)
    raise InvalidCSVError, "ファイルが選択されていません" if file.nil?

    begin
      csv = CSV.read(file.path, headers: false, encoding: 'bom|utf-8')
    rescue CSV::MalformedCSVError => e
      raise InvalidCSVError, "CSVの形式が不正です: #{e.message}"
    end

    raise InvalidCSVError, "CSVファイルにデータが含まれていません" if csv.empty?

    csv.each_with_index do |row, index|
      next if row.nil?

      subject_number = row[0].to_s.strip
      if subject_number.blank?
        raise InvalidCSVError, "#{index + 1}行目の科目番号が空です"
      end

      begin
        find_or_create_by!(
          user_email: current_user.email,
          subject_number: subject_number
        )
      rescue => e
        raise InvalidCSVError, "#{index + 1}行目の登録に失敗しました: #{e.message}"
      end
    end
  end

  belongs_to :user, foreign_key: :user_email, primary_key: :email
  belongs_to :subject, foreign_key: :subject_number, primary_key: :number
end
