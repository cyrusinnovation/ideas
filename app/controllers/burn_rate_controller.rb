class BurnRateController < ApplicationController
  def index
    @stories = Story.all :conditions => "estimate IS NOT NULL AND hours_worked IS NOT NULL", :order => "finished DESC"
    @average = Average.new(@stories) {|s| s.burn_rate }
  end
end
