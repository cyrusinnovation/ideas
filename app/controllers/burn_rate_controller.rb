class BurnRateController < ApplicationController
  def index
    @stories = Story.all_with_burn_rates
    @averages_by_estimate = Story.average_hours_by_estimate

    @estimate_groups = @averages_by_estimate.sort.map do |estimate, average|
      EstimateGroup.new(estimate.to_r, average)
    end

    @estimate_groups << EstimateGroup.new("All - Size", Average.new(@stories, :value => :hours_worked))
    @estimate_groups << EstimateGroup.new("All - Burn Rate", Average.new(@stories, :value => :burn_rate))
  end

  def average_sparkline
    values = params[:values].split(',').map { |s| s.to_i }
    sparkline = Sparklines.plot values,
                                :type => 'discrete',
                                :height => '16px',
                                :upper => 101,
                                :line_height => '2px',
                                :has_std_dev => true,
                                :below_color => '#666666',
                                :std_dev_color => '#eeeeff',
                                :background_color => '#ffff99'

    send_data(sparkline,
              :disposition => 'inline',
              :type => 'image/png',
              :filename => "average_sparkline.png")
  end
end

class EstimateGroup
  attr_reader :title, :average

  def initialize title, average
    @title = title
    @average = average
  end
end
