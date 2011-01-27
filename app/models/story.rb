class Story < ActiveRecord::Base
  def cycle_time
    date_range = started..finished
    date_range.select {|d| weekday?(d) }.size
  end

  private

  def weekday? date
    (1..5).include? date.wday
  end
end
