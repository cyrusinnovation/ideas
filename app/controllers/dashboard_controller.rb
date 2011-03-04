class DashboardController < ApplicationController
  def index
    @throughput = Throughput.new(Date.today)
    @throughput_history = Throughput.history.
        map { |t| t.points }.# points/3 weeks
        reverse.  # list comes in reverse chronological order, but we want to show line going forward in time
        last(120) # only show the last ~4 months
  end
end
