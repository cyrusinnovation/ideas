class CycleTimeController < ApplicationController
  def index
    @teams = Team.active
    stories = Story.all :conditions => "finished IS NOT NULL", :order => "finished DESC"
    @cycle_times = CycleTimeCalculator.new(stories).list_back
  end

  def team
    @teams = Team.active
    @team = Team.find params[:team]
    stories = @team.stories :conditions => "finished IS NOT NULL", :order => "finished DESC"
    @cycle_times = CycleTimeCalculator.new(stories).list_back
    render 'index'
  end
end
