class StaticPagesController < ApplicationController
  before_action :authenticate_user!
  def home
    @user = current_user
  end
  def map
    @user= current_user
  end
  def map
    @memos = Memo.all
    @memos = Memo.all 
    @new_memo = current_user.memos.new
    lat = "36.08622886"
    lon = "140.10623424" #  春日校舎の緯度、経度 
    service = WeatherService.new(lat, lon)
    @current = service.current_weather
    @forecasts = service.forecast_24h || []
  end  
end