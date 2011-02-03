class CycleTimeController < ApplicationController
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
