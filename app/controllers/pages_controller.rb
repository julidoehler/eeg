class PagesController < ApplicationController
  
  skip_before_filter :authenticate
  
  def contact
  end
  def search
    @search = params[:id]
  end
end
