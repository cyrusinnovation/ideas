require 'spec_helper'

describe "Updating project settings" do
  before do
    @user = sign_in_user
    @project = Project.create(:name => 'Test')
    @project.users << @user
    visit projects_path
  end

  it "should change the project name" do
    page.should have_content "Project Settings"
    fill_in 'name', :with => "Test Project"
    expect{
      click_button 'Save'
    }.to change(Idea, :count).by(0)
    @user.reload.projects.first.name.should == "Test Project"
  end

  it "should delete a collaborator" do
    expect{
      click_link 'Remove'
    }.to change(Membership, :count).by(-1)
    @user.reload.projects.count.should == 0
  end

  it "should add a collaborator" do
    other_user = User.create(:email => 'beth@email.com', :password => 'password')
    fill_in 'membership_user', :with => 'beth@email.com'
    expect{
      click_button 'Add Collaborator'
    }.to change(Membership, :count).by(1)
    @project.reload.users.should include(other_user)
  end

  it "should throw an error when cannot find email of a collaborator" do
    fill_in 'membership_user', :with => 'fake_user@email.com'
    expect{
      click_button 'Add Collaborator'
    }.to change(Membership, :count).by(0)
    page.should have_content "Sorry, couldn't find a user with fake_user@email.com as their email address"
  end

  it "should delete the project" do
    expect{
      click_on 'Delete this project'
    }.to change(Project, :count).by(-1)
    page.should have_content "Project Test deleted!"
  end
end