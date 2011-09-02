class DashboardController < ApplicationController
  def index
    throughput_history = Throughput.history.
        map { |t| t.points }.# points/3 weeks
        reverse.  # list comes in reverse chronological order, but we want to show line going forward in time
        last(120) # only show the last ~4 months
    @throughputs = DataSeries.new throughput_history

    cycle_time_history = Story.all_with_cycle_times.
        map { |s| s.cycle_time }.
        reverse.
        last(120)
    @cycle_times = DataSeries.new cycle_time_history

    burn_rate_history = Story.all_with_burn_rates.
        map { |s| s.burn_rate }.
        reverse.
        last(120)
    @burn_rates = DataSeries.new burn_rate_history
  end
end
