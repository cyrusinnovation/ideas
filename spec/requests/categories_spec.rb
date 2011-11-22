require 'spec_helper'

describe "Categories" do
  describe "GET /categories" do
    it "works! (now write some real specs)" do
      get categories_path
      response.status.should be(200)
    end
  end
end
