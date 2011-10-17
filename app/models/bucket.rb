class Bucket < ActiveRecord::Base
  EXAMPLE_DELTA = 0.2

  belongs_to :project
  validates_uniqueness_of :value, :scope => :project_id
  validates_numericality_of :value, :greater_than => 0, :less_than => 1000, :allow_nil => false

  def pretty_print_html
    return '&frac14;' if value == 0.25
    return '&frac12;' if value == 0.5
    value.to_i
  end

  def pretty_print
    return value if value == 0.25 || value == 0.5
    value.to_i
  end

  def estimate_hours
    project.target_point_size * value
  end

  def min
    estimate_hours * (1 - EXAMPLE_DELTA)
  end

  def max
    estimate_hours * (1 + EXAMPLE_DELTA)
  end
end
