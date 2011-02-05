class BurnRateController < ApplicationController
  def index
    @stories = Story.all_with_burn_rates
    @averages_by_estimate = Story.average_hours_by_estimate

    @estimate_groups = @averages_by_estimate.sort.map do |estimate, average|
      EstimateGroup.new(estimate.to_r, average)
    end

    @estimate_groups << EstimateGroup.new("All Stories Burn Rate", Average.new(@stories, :value => :burn_rate))
  end
end

class EstimateGroup
  attr_reader :title, :average

  def initialize title, average
    @title = title
    @average = average
  end
end
