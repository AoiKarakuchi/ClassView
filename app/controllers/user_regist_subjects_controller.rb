class UserRegistSubjectsController < ApplicationController
  before_action :authenticate_user!

  def import
    if params[:file].present?
      begin
        UserRegistSubject.import(params[:file], current_user)
        flash[:success] = "履修科目をインポートしました"
        redirect_to user_regist_subjects_path
      rescue UserRegistSubject::InvalidCSVError => e
        flash[:danger] = "インポート失敗: #{e.message}"
        redirect_to user_regist_subjects_path
      rescue => e
        Rails.logger.error "予期せぬエラー: #{e.message}"
        flash[:danger] = "予期せぬエラーが発生しました"
        redirect_to user_regist_subjects_path
      end
    else
      flash[:danger] = "CSVファイルを選択してください"
      redirect_to user_regist_subjects_path
    end
  end
end
