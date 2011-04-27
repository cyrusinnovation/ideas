class CycleTimeController < ApplicationController
  def index
    @estimate_groups = EstimateGroups.new(Story.all_with_cycle_times) { |s| s.cycle_time}
    @stories = Story.all_with_cycle_times
  end
end
