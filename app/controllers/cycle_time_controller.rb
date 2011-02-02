class CycleTimeController < ApplicationController
  def index
    @teams = Team.active
    stories = Story.all :conditions => "finished IS NOT NULL", :order => "finished DESC"
    @cycle_times = CycleTimeCalculator.new(stories).list_back
  end
end
