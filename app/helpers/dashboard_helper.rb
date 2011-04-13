module DashboardHelper
  def average_sparkline average
    sparkline average.normal_range_min, average.normal_range_max, average.values
  end

  def smoothed_average_sparkline average
    values = average.values
    smoothed_values = []
    values.each_index do |i|
      if i < 5
        smoothed_values << values[i]
      else
        smoothed_values << Average.new(values[i-4, 5]).mean
      end
    end
    sparkline average.normal_range_min, average.normal_range_max, smoothed_values
  end

  def sparkline normal_range_min, normal_range_max, values
    content_tag 'span',
        "...",
        :values => "#{values.join(',')}",
        :sparkNormalRangeMin => normal_range_min,
        :sparkNormalRangeMax => normal_range_max,
        :sparkChartRangeMin => 0,
        :sparkLineColor => '#666666',
        :sparkNormalRangeColor => '#e0f0ff',
        :sparkFillColor => 'false',
        :sparkMinSpotColor => '#990000',
        :sparkMaxSpotColor => '#009900',
        :sparkSpotRadius => 2,
        :class => 'sparkline',
        :style => 'vertical-align: bottom'
  end

  def normal_range average
    "(normal range is between #{average.normal_range_min.round} and #{average.normal_range_max.round})"
  end
end
