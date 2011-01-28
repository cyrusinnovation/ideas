class Holiday < ActiveRecord::Base
  def self.holiday? date
    find_by_date(date)
  end
end
