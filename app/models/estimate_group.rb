class EstimateGroup
  attr_reader :title, :data_series

  def self.collect(data_grouped_by_estimate)
    data_grouped_by_estimate.delete(nil) # test me! this removes things with nil estimate
    data_grouped_by_estimate.sort.map do |estimate, data_series|
      EstimateGroup.new(estimate.to_r.to_s, data_series)
    end
  end

  def initialize title, data_series
    @title = title
    @data_series = data_series
  end
end
