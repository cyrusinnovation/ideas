module BurnRateHelper
  def discrete_sparkline group
    content_tag 'span',
        "...",
        :sparkType => 'discrete',
        :sparkLineColor => '#666666',
        :values => "#{group.data_series.first(30).values.reverse.join(',')}",
        :class => 'sparkline'
  end

  def data_series_sparkline data_series
    sparkline data_series.normal_range_min, data_series.normal_range_max, data_series.values
  end

  def smoothed_data_series_sparkline data_series
    values = data_series.values
    smoothed_values = []
    values.each_index do |i|
      if i < 5
        smoothed_values << values[i]
      else
        smoothed_values << DataSeries.new(values[i-4, 5]).mean
      end
    end
    sparkline data_series.normal_range_min, data_series.normal_range_max, smoothed_values
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

  def normal_range data_series
    "(normal range is between #{data_series.normal_range_min.round} and #{data_series.normal_range_max.round})"
  end  
end
