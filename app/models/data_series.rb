class DataSeries
  def self.by_group values, options={}, &block
    grouped_values = values.group_by {|v| v.send(options[:group]) }
    Hash[grouped_values.map {|k, v| [k, DataSeries.new(v, &block)] }]
  end

  def self.empty
    DataSeries.new([])
  end

  attr_reader :values

  def initialize values, &block
    values = values.map(&block) if block_given?
    @values = values.reject {|v| v.nil? }
  end

  def first n
    DataSeries.new @values.first(n)
  end

  def last n
    DataSeries.new @values.last(n)
  end

  def mean
    return nil if @values.empty?
    @values.reduce(:+) / count
  end

  def standard_deviation
    return nil if @values.empty?
    Math.sqrt variance
  end

  def normal_range_min
    return nil if @values.empty?
    mean - standard_deviation
  end

  def normal_range_max
    return nil if @values.empty?
    mean + standard_deviation
  end

  def variance
    sum_of_squared_deviations = @values.reduce(0) {|sum, value| sum + (value - mean)**2 }
    sum_of_squared_deviations / count
  end

  def count
    @values.size.to_f
  end

  def last_value
    @values.last
  end

  def to_html
    return nil if @values.empty?
    '<span title="%.2f &plusmn; %.2f">%.0f &plusmn; %.0f</span>' % [mean, standard_deviation, mean, standard_deviation]
  end

  def to_html_attribute
    return nil if @values.empty?
    '%.0f &plusmn; %.0f' % [mean, standard_deviation]
  end

  def empty?
    @values.empty?
  end
end