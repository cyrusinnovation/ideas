class CycleTimeController < ApplicationController
  def index
    stories = Story.all :conditions => "finished IS NOT NULL", :order => "finished DESC"
    @cycle_times = CycleTimeCalculator.new(stories).list_back
  end
end
