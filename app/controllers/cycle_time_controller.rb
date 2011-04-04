class CycleTimeController < ApplicationController
  caches_action :index
  caches_action :team
  cache_sweeper :story_sweeper

  def index
    @teams = Team.active
    @cycle_times = CycleTimeCalculator.collect Story
    @estimate_groups = EstimateGroup.collect(Story.average_cycle_time_by_estimate)
  end

  def team
    @teams = Team.active
    @team = Team.find params[:team]
    @cycle_times = CycleTimeCalculator.collect @team.stories
    stories_with_cycle_times = @team.stories.reject { |s| s.cycle_time.nil? || s.estimate.nil? }
    averages = Average.by_group stories_with_cycle_times, :group => :estimate, :value => :cycle_time
    @estimate_groups = EstimateGroup.collect(averages)
    render 'index'
  end
end
