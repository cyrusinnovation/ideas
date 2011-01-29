class HolidaysController < ApplicationController
  def index
    @holidays = Holiday.all :order => "date DESC"
    @new_holiday = Holiday.new
  end

  def create
    Holiday.create params[:holiday]
    redirect_to :action => :index
  end

  def destroy
    Holiday.find(params[:id]).delete
    redirect_to :action => :index
  end
end
