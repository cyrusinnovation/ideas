class EstimateGroup
  attr_reader :title, :average

  def self.collect(map_of_averages_by_estimate)
    map_of_averages_by_estimate.delete(nil) # test me! this removes things with nil estimate
    map_of_averages_by_estimate.sort.map do |estimate, average|
      EstimateGroup.new(estimate.to_r.to_s, average)
    end
  end

  def initialize title, average
    @title = title
    @average = average
  end
end
