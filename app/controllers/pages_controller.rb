class PagesController < ApplicationController
  def contact
  end
  def contact_send_mail
    @mail = params[:mail]
    flash = "fill in everything!"
    unless @mail['name'].empty? and @mail['email'].empty? and @mail['message'].empty?
      Mailer.deliver_contact_mail(@mail)
      flash = "Mail has been sent!"
    end
    redirect_to(:action => 'contact', :flash => flash) 
  end
  def search
    @search = params[:id]
  end
  def schedule
    @dates = Post.find(:all, :select => "date_from, title") + projects = Project .find(:all, :select => "date_from, title")
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
end
