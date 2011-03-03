module BurnRateHelper
  def status story
    difference = hours_vs_average(story)
    return nil if difference.nil?
    difference < 0 ? 'overestimated' : 'underestimated'
  end

  def hours_vs_average story
    average = average(story)
    difference = story.hours_worked - average.mean
    difference.abs < average.standard_deviation ? nil : difference.round
  end

  def average story
    @averages_by_estimate[story.estimate]
  end

  def sparkline group
    content_tag 'span',
        "...",
        :sparkType => 'discrete',
        :sparkLineColor => '#666666',
        :values => "#{group.average.values.reverse.join(',')}",
        :class => 'sparkline'
  end
end
