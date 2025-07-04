class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  def home
    @user = current_user
  end
  def map
    @user= current_user
  end
end
