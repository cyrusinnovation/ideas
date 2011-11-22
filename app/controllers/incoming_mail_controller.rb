class IncomingMailController < ApplicationController    
  require 'mail'
  skip_before_filter :verify_authenticity_token

  def create
    message = Mail.new(params[:message])

    user = User.find_by_email(message.from)

    if user
      user.projects.each do |project|
        project.ideas << Idea.create(:title => message.subject, :description => message.body.decoded)
      end
    
      render :text => 'success', :status => 200
    else
      render :text => 'failure', :status => 404
    end
  end
end

