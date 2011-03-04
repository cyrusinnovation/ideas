module DashboardHelper
  def throughput_history
    average = Average.new(@throughput_history)
    content_tag 'span',
        "...",
        :values => "#{@throughput_history.join(',')}",
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
end
