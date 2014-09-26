class PagesController < ApplicationController
  include HighVoltage::StaticPage

  before_filter :redirect_to_user_page_from_home

  protected

  def redirect_to_user_page_from_home
    if params[:id] == "home" && current_user
      redirect_to "/#{current_user.friendly_id}"
    end
  end
end
