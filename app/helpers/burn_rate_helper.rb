module BurnRateHelper
  def discrete_sparkline group
    content_tag 'span',
        "...",
        :sparkType => 'discrete',
        :sparkLineColor => '#666666',
        :values => "#{group.data_series.first(30).values.reverse.join(',')}",
        :class => 'sparkline'
  end
end
