require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  def setup
    @user = User.create({email:"ben@franklin.com", password:"electric"})
  end
end
