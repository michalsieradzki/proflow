class StaticPagesController < ApplicationController
  skip_before_action :authenticate_user!  # publiczne strony
  
  def show
    @static_page = StaticPage.published.find_by!(slug: params[:slug])
  end
end 