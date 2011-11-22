class IncomingMailController < ApplicationController    
  require 'mail'
  skip_before_filter :verify_authenticity_token

  def create
    message = Mail.new(params[:message])
    Rails.logger.add Logger::INFO, params[:message]
    user = User.find_by_email(message.from)

    if user
      if mail.multipart?
        text = plain_text_body(mail)
      else
        text = message.body.decoded
      end
      
      user.projects.each do |project|
        project.ideas << Idea.create(:title => message.subject, :description => text)
      end
    
      render :text => 'success', :status => 200
    else
      render :text => 'failure', :status => 404
    end
  end

  def plain_text_body(email)
    parts = email.parts.collect {|c| (c.respond_to?(:parts) && !c.parts.empty?) ? c.parts : c}.flatten
    if parts.empty?
      parts << email
    end
    plain_text_part = parts.detect {|p| p.content_type == 'text/plain'}
    if plain_text_part.nil?
      # no text/plain part found, assuming html-only email
      # strip html tags and remove doctype directive
      plain_text_body = strip_tags(email.body.to_s)
      plain_text_body.gsub! %r{^<!DOCTYPE .*$}, ''
    else
      plain_text_body = plain_text_part.body.to_s
    end
    plain_text_body.strip
  end

end

