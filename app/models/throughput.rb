class Throughput
  def self.history
    start_date = Story.first(:order => "finished", :conditions => "finished IS NOT NULL").finished + 20
    date_range = start_date..Date.today
    date_range.map { |date|
      Throughput.new date
    }.reverse
  end

  attr_reader :date

  def initialize date
    @date = date
  end
end