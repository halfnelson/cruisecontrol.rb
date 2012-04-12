# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  helper_method :current_user
  before_filter :auth

  def render_not_found
    render :file => Rails.root.join('public', '404.html').to_s, :status => 404
  end

  def disable_build_triggers
    return unless Configuration.disable_admin_ui
    render :text => 'Build requests are not allowed', :status => :forbidden
  end


  def auth
    if current_user.nil? && params[:controller] != 'sessions'
      logger.debug("auth needed: current user: #{current_user} controller: #{params[:controller]}" )
      redirect_to signin_path
    end

  end

  private

  def current_user
    @current_user ||= session[:user_id] if session[:user_id]
  end


end
