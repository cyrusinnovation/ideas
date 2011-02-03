class Average
  def initialize values
    @values = values
  end

  def mean
    @values.reduce(:+) / @values.size
  end
end