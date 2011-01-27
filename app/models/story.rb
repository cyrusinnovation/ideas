class Story < ActiveRecord::Base
  def cycle_time
    finished - started + 1
  end
end
