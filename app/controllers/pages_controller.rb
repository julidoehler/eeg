class PagesController < ApplicationController
  
  skip_before_filter :authenticate, :except => [:background_edit, :background_update, :update_background_for]
  
  def background_edit
    @default = Background.new
    @members = Background.new
    @projects = Background.new
    @profile = Background.new
    @donation = Background.new
  end
    
  def background_update
    update_background_for(params[:default])
    update_background_for(params[:members])
    update_background_for(params[:projects])
    update_background_for(params[:profile])
    update_background_for(params[:donation])
    
    redirect_to :action => 'background_edit'
  end
  
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
    @dates = Post.find(:all, :select => "id, date_from, title").map! {|m| m unless m.date_from.nil?}.compact + Project.find(:all, :select => "id, date_from, title")
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
  
  def update_background_for(params)   
    bg = Background.find(:first, :conditions => "parent_id = '0' AND parent_type = '#{params['parent_type']}'")
    bg.destroy if params['delete'] == '1' unless bg.nil?
    
    if params.has_key?("data") and params['delete'] == '0'
      params.delete("delete")
      if bg
        bg.update_attributes(params)
      else
        Background.create(params)
      end
    end
  end
end
