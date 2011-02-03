class BurnRateController < ApplicationController
  def index
    @stories = Story.all :conditions => "estimate IS NOT NULL AND hours_worked IS NOT NULL", :order => "finished DESC"
  end
end
