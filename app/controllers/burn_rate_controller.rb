class BurnRateController < ApplicationController
  def index
    @estimate_groups = EstimateGroups.new(Story.all_with_burn_rates)
    @stories = Story.all_with_burn_rates.map {|s| @estimate_groups.story_vs_estimate(s) }
  end
end
