class PagesController < ApplicationController
  
  skip_before_filter :authenticate
  
  def contact
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
end
