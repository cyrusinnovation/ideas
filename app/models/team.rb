class Team < ActiveRecord::Base
  has_many :stories

  def self.active
    [find_by_name('ShARC'), find_by_name('Schildkroete')]
  end
end
