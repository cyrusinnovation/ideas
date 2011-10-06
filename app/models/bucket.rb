class Bucket < ActiveRecord::Base
  belongs_to :user
  validates_uniqueness_of :value, :scope => :user_id

  def pretty_print_html
    return '&frac14;' if value == 0.25
    return '&frac12;' if value == 0.5
    value.to_i
  end
end
