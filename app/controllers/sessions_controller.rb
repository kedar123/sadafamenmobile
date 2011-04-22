# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
   layout 'login'
  # render new.rhtml
  def new
  end

  def create 
    notice = "Logged In Successfully" 
    logout_keeping_session!
    user = User.authenticate(params[:login], params[:password])
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      if session[:friendid].blank?
      else  
        tempuser = User.find(session[:friendid])
        tempuser.invite current_user
        session[:friendid] = nil
        notice = "Logged in Successfully Please Accept The Invitation"  
      end    
      redirect_back_or_default('/', :notice => notice)
    else
      note_failed_signin
      flash[:notice]="Please Enter Correct Login And Password"
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    redirect_back_or_default('/login', :notice => "You have been logged out.")
  end
  
 
protected
  # Track failed login attempts
  def note_failed_signin
    flash.now[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
