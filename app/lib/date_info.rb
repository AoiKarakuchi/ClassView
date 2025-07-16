# 年・曜日・学期の動的取得
# 年度が替わったらspanを変更
require "date"
module DateInfo
  def self.year
    Date.today.year
  end

  def self.weekday
    %w[日 月 火 水 木 金 土][Date.today.wday]
  end

  def self.semester
    today = Date.today
    now = today.strftime("%m%d").to_i

    semesters = %w[秋C 春季休業中 春A 春B 春C 夏季休業中 秋A 秋B 秋C]
    span = [ 0, 216, 413, 522, 703, 807, 930, 1110, 1226 ]

    semesters.each_with_index do |sem, i|
      return sem if now > span[i] && now <= span[i + 1]
    end

    "春A"  # デフォルト
  end

  def self.time
    current_time=Time.now
    time_string=current_time.strftime("%H%M").to_i
    times=%w[1 2 3 4 5 6 7 8]
    span=[ 0, 955, 1125, 1330, 1500, 1630, 1800, 1915, 2035 ]
    times.each_with_index do |time, i|
      return time if time_string>span[i] && time_string<=span[i+1]
    end
    1
  end
end
