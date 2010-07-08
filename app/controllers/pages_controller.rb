class PagesController < ApplicationController
  
  skip_before_filter :authenticate
  
  def contact
  end
  
  def contact_send_mail
    @mail ||= params[:mail]
    flash[:notice] = "Please fill in everything!"
    unless @mail['name'].empty? or @mail['email'].empty? or @mail['message'].empty?
      Mailer.deliver_contact_mail(@mail)
      flash[:notice] = "Your mail has been sent!"
    end
    redirect_to :action => 'contact'
  end
  
  def search
    @search = params[:id]
  end
  
  def schedule
    @dates = Post.find(:all, :select => "id, date_from, title") + projects = Project .find(:all, :select => "id, date_from, title")
    @dates.sort! { |a,b| a.date_from <=> b.date_from }
  end
  
  def profile
  end
  
  def imprint
  end
  
  def directions
  end
  
  def archive
  end
  
  def donation
  end
end
