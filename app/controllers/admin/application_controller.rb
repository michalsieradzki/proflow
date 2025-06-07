class Admin::ApplicationController < ApplicationController
  before_action :ensure_admin_access
  
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: "Access denied. You don't have permission to access this area."
  end
  
  private
  
  def ensure_admin_access
    redirect_to new_user_session_path unless user_signed_in?
    unless current_user.admin_access?
      redirect_to root_path, alert: "Access denied. Admin privileges required."
    end
  end
end 