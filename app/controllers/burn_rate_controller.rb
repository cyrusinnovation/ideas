class BurnRateController < ApplicationController
  def index
    @stories = Story.all_with_burn_rates
    @averages_by_estimate = Story.average_hours_by_estimate
    @estimate_groups = EstimateGroup.collect(@averages_by_estimate)

    @estimate_groups << EstimateGroup.new("All - Story", Average.new(@stories, :value => :hours_worked))
    @estimate_groups << EstimateGroup.new("All - Point", Average.new(@stories, :value => :burn_rate))
  end
end
