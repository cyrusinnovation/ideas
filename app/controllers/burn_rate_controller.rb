class BurnRateController < ApplicationController
  def index
    @stories = Story.all :conditions => "estimate IS NOT NULL AND hours_worked IS NOT NULL", :order => "finished DESC"
    @estimate_groups = []

    stories_by_estimate = @stories.group_by {|s| s.estimate }.sort
    @estimate_groups += stories_by_estimate.map do |estimate, stories|
      EstimateGroup.new(estimate.to_r, stories) {|s| s.hours_worked }
    end

    @estimate_groups << EstimateGroup.new("All Stories Burn Rate", @stories) {|s| s.burn_rate }
  end
end

class EstimateGroup
  attr_reader :title, :average

  def initialize title, stories, &block
    @title = title
    @average = Average.new(stories, &block)
  end
end
