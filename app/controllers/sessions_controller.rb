class SessionsController < ApplicationController

  def valid_user?(email)
    email.downcase.include? "@apollosoftware.com.au"
  end

  def create
    info = request.env["omniauth.auth"]["info"]
    if valid_user?(info.email)
      session[:user_id] = info.email
      redirect_to root_url, :notice => "Signed in!"
    else
      redirect_to signin_path
    end

  end

  def failure
    redirect_to signin_path, :notice => "Google Auth Failure"
  end

  def destroy
    session[:user_id] = nil
    redirect_to signin_path, :notice => "Signed out!"
  end



end
