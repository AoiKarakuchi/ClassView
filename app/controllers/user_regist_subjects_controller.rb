class UserRegistSubjectsController < ApplicationController
  before_action :authenticate_user!

  def import
    if params[:file].present?
      begin
        UserRegistSubject.import(params[:file], current_user)
        redirect_to user_regist_subjects_path, notice: "履修科目をインポートしました"
      rescue UserRegistSubject::InvalidCSVError => e
        redirect_to user_regist_subjects_path, alert: "インポート失敗: #{e.message}"
      rescue => e
        Rails.logger.error "予期せぬエラー: #{e.message}"
        redirect_to user_regist_subjects_path, alert: "予期せぬエラーが発生しました"
      end
    else
      redirect_to user_regist_subjects_path, alert: "CSVファイルを選択してください"
    end
  end
end
