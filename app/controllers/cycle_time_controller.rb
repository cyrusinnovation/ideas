class CycleTimeController < ApplicationController
  def index
    stories = Story.all :conditions => "finished IS NOT NULL", :order => "finished DESC"
    @cycle_time = CycleTimeCalculator.new stories
  end
end
