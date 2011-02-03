class CycleTimeController < ApplicationController
  caches_action :index
  caches_action :team
  cache_sweeper :story_sweeper

  def index
    @teams = Team.active
    @cycle_times = CycleTimeCalculator.collect Story
  end

  def team
    @teams = Team.active
    @team = Team.find params[:team]
    @cycle_times = CycleTimeCalculator.collect @team.stories
    render 'index'
  end
end
