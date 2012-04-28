class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # Fetch current user
  before_filter :fetch_current_user
  
  def fetch_current_user
    return unless session[:user_id]
    @current_user = User.find(session[:user_id])
  end
  def logged_in?
    !@current_user.nil?
  end
  helper_method :logged_in?
  
  
  # Login required
  before_filter :authenticate, :only => [:bid]
  
  def authenticate
    if !logged_in?
      render :nothing => true, :status => 403
    end
  end
  
  
  # Generic 404 page
  def render_404
    render 'public/404.html', :status => 404, :layout => false
  end
end
