class EstimateGroup
  attr_reader :title, :data_series, :group_amount

  def self.collect(data_grouped_by_estimate)
    data_grouped_by_estimate.delete(nil) # test me! this removes things with nil estimate
    data_grouped_by_estimate.sort.map do |estimate, data_series|
      EstimateGroup.new(estimate.to_s, data_series, estimate)
    end
  end

  def initialize title, data_series, group_amount
    @title = title
    @data_series = data_series
    @group_amount = group_amount
  end
end
