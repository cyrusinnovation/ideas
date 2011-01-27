class Story < ActiveRecord::Base
  def cycle_time
    date_range = started..finished
    date_range.select {|d| workday?(d) }.size
  end

  private

  def workday? date
    weekday?(date) and not_holiday?(date)
  end

  def weekday? date
    (1..5).include? date.wday
  end

  def not_holiday? date
    Holiday.find_by_date(date).nil?
  end
end
