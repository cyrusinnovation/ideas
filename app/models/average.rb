class Average
  def self.by_group values, options={}
    grouped_values = values.group_by {|v| v.send(options[:group]) }
    averaged_groups = grouped_values.map {|k, v| [k, Average.new(v, options)] }
    Hash[averaged_groups]
  end

  def initialize values, options={}
    values = values.map{|v| v.send(options[:value]) } if options.include?(:value)
    @values = values.reject {|v| v.nil? }
  end

  def first n
    Average.new @values.first(n)
  end

  def mean
    @values.reduce(:+) / count
  end

  def standard_deviation
    Math.sqrt variance
  end

  def variance
    mean = self.mean
    sum_of_squared_deviations = @values.reduce(0) {|sum, value| sum + (value - mean)**2 }
    sum_of_squared_deviations / count
  end

  def count
    @values.size.to_f
  end

  def to_html
    '<span title="%.2f &plusmn; %.2f">%.0f &plusmn; %.0f</span>' % [mean, standard_deviation, mean, standard_deviation]
  end
end