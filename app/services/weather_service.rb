class WeatherService
  include HTTParty
  base_uri 'https://api.openweathermap.org/data/2.5'

  def initialize(lat, lon)
    @lat = lat
    @lon = lon
    @api_key = ENV['OPENWEATHER_API_KEY']
  end

  def current_weather
    options = {
      query: {
        lat: @lat,
        lon: @lon,
        appid: @api_key,
        units: 'metric',
        lang: 'ja'
      }
    }

    response = self.class.get('/weather', options)
    if response.success?
      response.parsed_response
    else
      []
    end
  end

  def forecast_24h
    options = {
      query: {
        lat: @lat,
        lon: @lon,
        appid: @api_key,
        units: 'metric',
        lang: 'ja'
      }
    }

    response = self.class.get('/forecast', options)
    if response.success? && response['list']
      now = Time.current.utc        # 現在のUTC時刻（APIの dt_txt も UTC）
      limit = now + 15.hours

      response['list'].select do |entry|
        forecast_time = Time.parse(entry['dt_txt']) # 予報時刻をTimeに変換
        forecast_time >= now && forecast_time <= limit
      end
    else
      []
    end
  end

end