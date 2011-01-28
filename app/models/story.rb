class Story < ActiveRecord::Base
  def self.list_newest_first
    Story.all.sort { |a, b| compare_nulls_first(a.started, b.started) }
  end

  def cycle_time
    return nil if started.nil?
    return nil if finished.nil?
    date_range = started..finished
    date_range.select {|d| workday?(d) }.size
  end

  private

  def self.compare_nulls_first(a, b)
    return -1 if a.nil?
    return 1 if b.nil?
    -(a <=> b)
  end

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
