class BurnRateController < ApplicationController
  def index
    @stories = Story.all :conditions => "estimate IS NOT NULL AND hours_worked IS NOT NULL", :order => "finished DESC"

    @averages_by_estimate = Average.by_group @stories, :group => :estimate, :value => :hours_worked

    @estimate_groups = @averages_by_estimate.sort.map do |estimate, average|
      EstimateGroup.new(estimate.to_r, average)
    end

    @estimate_groups << EstimateGroup.new("All Stories Burn Rate", Average.new(@stories, :value => :burn_rate))
  end
end

class EstimateGroup
  attr_reader :title, :average

  def initialize title, average
    @title = title
    @average = average
  end
end
