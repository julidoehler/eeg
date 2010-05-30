class PagesController < ApplicationController
  def contact
  end
  def search
    @search = params[:id]
  end
end
