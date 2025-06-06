class UserRegistSubjectsController < ApplicationController
  before_action :authenticate_user!

  def import
    if params[:file].present?
      UserRegistSubject.import(params[:file], current_user)
      redirect_to user_regist_subjects_path, notice: '履修科目をインポートしました'
    else
      redirect_to user_regist_subjects_path, alert: 'CSVファイルを選択してください'
    end
  end
end
