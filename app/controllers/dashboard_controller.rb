class DashboardController < ApplicationController
  def index
    @throughput = Throughput.new(Date.today)
  end

  def throughput_sparkline
    history = Throughput.history.
        map { |t| t.points }. # points/3 weeks
        reverse. # list comes in reverse chronological order, but we want to show line going forward in time
        last(120) # only show the last ~4 months

    sparkline = Sparklines.plot history,
                                :type => 'smooth',
                                :height => '72px',
                                :has_std_dev => true,
                                :has_min => true,
                                :has_max => true,
                                :std_dev_color => '#f0f8ff'

    send_data( sparkline,
          :disposition => 'inline',
          :type => 'image/png',
          :filename => "spark_#{params[:type]}.png" )
  end
end
