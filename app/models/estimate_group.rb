class EstimateGroup
  attr_reader :title, :average

  def self.collect(map_of_averags_by_estimate)
    map_of_averags_by_estimate.sort.map do |estimate, average|
      EstimateGroup.new(estimate.to_r, average)
    end
  end

  def initialize title, average
    @title = title
    @average = average
  end
end
