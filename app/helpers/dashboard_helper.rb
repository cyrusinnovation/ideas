module DashboardHelper
  def average_sparkline average
    content_tag 'span',
        "...",
        :values => "#{average.values.join(',')}",
        :sparkNormalRangeMin => average.normal_range_min,
        :sparkNormalRangeMax => average.normal_range_max,
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
