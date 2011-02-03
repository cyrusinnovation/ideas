class BurnRateController < ApplicationController
  def index
    @stories = Story.all :conditions => "estimate IS NOT NULL AND hours_worked IS NOT NULL", :order => "finished DESC"
    @estimate_groups = @stories.
        group_by {|s| s.estimate }.
        map {|estimate, stories| EstimateGroup.new(estimate, stories)}.
        sort
    @average = Average.new(@stories) {|s| s.burn_rate }
  end
end

class EstimateGroup
  attr_reader :estimate, :average

  def initialize estimate, stories
    @estimate = estimate
    @average = Average.new(stories) {|s| s.burn_rate }
  end

  def <=> other
    estimate <=> other.estimate
  end
end
