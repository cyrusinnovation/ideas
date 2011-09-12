class DateRange
  def self.days_up_to finished_date, days
    started_date = finished_date
    count = 1
    while count < days
      started_date -= 1
      count += 1 if started_date.extend(DateExtensions).workday?
    end
    DateRange.new(started_date, finished_date)
  end

  attr_reader :started, :finished

  def initialize started, finished
    @started = started
    @finished = finished
  end

  def workdays
    return nil if started.nil?
    return nil if finished.nil?
    filtered_range.size
  end

  private

  def filtered_range
    date_range = started..finished
    filtered = date_range.select { |d| d.extend(DateExtensions).workday? }
    filtered.unshift(started).push(finished).uniq
  end
end

module DateExtensions
  def workday?
    weekday?
  end

  def weekday?
    (1..5).include? wday
  end
end
