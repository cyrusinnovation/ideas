class CycleTimeController < ApplicationController
  def index
    @stories = Story.all_with_cycle_times
    @estimate_groups = EstimateGroup.collect(Story.average_cycle_time_by_estimate)
  end
end
