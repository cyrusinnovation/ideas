require 'spec_helper'

describe "Adding a new idea" do
  before do
    @user = sign_in_user
    @user.projects << Project.create(:name => 'Test')
    Category.create(:name => 'Solution')
  end
  it "should open form to add a new idea" do
    visit projects_path
    page.should have_content "Test"
    page.should have_content "Submit a new idea"
    fill_in 'Title', :with => "Test idea"
    fill_in 'Description', :with => 'Tester'
    select 'Solution', :from => 'Category'
    expect{
      click_button 'Create'
    }.to change(Idea, :count).by(1)
  end
end