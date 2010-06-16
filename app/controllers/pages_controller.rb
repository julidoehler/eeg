class PagesController < ApplicationController
  
  skip_before_filter :authenticate
  
  def contact
  end
  def search
    @search = params[:id]
  end
  def schedule
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
