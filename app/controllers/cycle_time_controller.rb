class CycleTimeController < ApplicationController
  def index
    @cycle_time = CycleTimeCalculator.new Story.list_newest_first
  end
end
