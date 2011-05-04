module BurnRateHelper
  def discrete_sparkline group
    content_tag 'span',
        "...",
        :sparkType => 'discrete',
        :sparkLineColor => '#666666',
        :values => "#{group.average.first(30).values.reverse.join(',')}",
        :class => 'sparkline'
  end
end
