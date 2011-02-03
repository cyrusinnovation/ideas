class Average
  def initialize values, &block
    if block_given?
      values = values.map &block
    end
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
    "%.1f &plusmn; %.1f" % [mean, standard_deviation]
  end
end