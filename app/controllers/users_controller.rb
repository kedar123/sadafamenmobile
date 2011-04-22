class UsersController < ApplicationController
  layout 'login' 
  before_filter :check_the_login,:only=>:user_action
   def check_the_login
      if logged_in?
      else 
        flash[:notice] = "Please Login"
         redirect_to "/login"
      end  
   end  

  def my_profile
    
  end    
 
  def code_image 
     @image_data = User.find(params[:id])
     @image = @image_data.binary_data
     send_data(@image,:type => @image_data.content_type ,:filename =>        @image_data.filename , :disposition => 'inline')
  end
 
 
 
  def edit_profile
    render :layout=> 'editprofile'
  end  

  def edit_image
    render :layout=> 'editprofile'
  end  

  def update_image
	  
	  if params[:user].blank? or params[:user][:image_file].blank?
		  flash[:notice] = "Please Enter Image To Change"
		  redirect_to :back
	  else
		if((params[:user][:image_file].content_type.chomp == "image/jpg") or (params[:user][:image_file].content_type.chomp == "image/png") or (params[:user][:image_file].content_type.chomp == "image/jpeg") or (params[:user][:image_file].content_type.chomp == "image/gif"))
			current_user.image_file(params[:user][:image_file])		
			flash[:notice] = "Your Changes Has Been Updated"
			redirect_to :back
		else
		   flash[:notice] = "Please Enter Valid Image "
		  redirect_to :back
		end			
		  
          end		  
  end	  


  def update_profile
    
    current_user.update_attributes(params[:user])
    current_user.image_file = params[:user][:image_file]
    current_user.save
      if !current_user.errors.full_messages.blank?
       flash[:notice] = "Please Enter Correct Information To Update "
       render :action=>"edit_profile",:layout=>'editprofile'
      else 
       flash[:notice] = "Your Changes Has Been Updated"
       redirect_to "/users/edit_profile"
      end
  end   



  # render new.rhtml
  def new
    @user = User.new
  end
 
  def create
    logout_keeping_session!
    @user = User.new(params[:userr])
    @user.image_file(params[:userr][:image_file])
    success = @user && @user.save 
    if success && @user.errors.empty?
       notice = "Logged in Successfully"
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      #here i need to send email to the registered user
      self.current_user = @user # !! now logged in
      Notifier.send_welcome_registration(@user,request.host_with_port).deliver
      if !session[:friendid].blank?
        tempuser = User.find(session[:friendid])
        session[:friendid] = nil
        tempuser.invite current_user
        notice = "Logged in Successfully Please Accept The Invitation Of Your Friend By Clicking On   Invitation Pending" 
      end
      flash[:notice]=notice
      redirect_back_or_default('/')
    else
      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

  def user_action
	  
      total_friend_user = current_user.friends
      total_friend_ids = []
      total_friend_user.each {|frid|  total_friend_ids << frid.id  }      
      total_friend_ids << current_user.id
      @uprayer=[]
      @uprayer = Prayer.find(:all,:conditions=>"user_id in (#{total_friend_ids.join(',')})",:order =>"id desc")
      @usercomments = []
      @uprayer.each {|epry|  @usercomments << epry.comments }
      @usercomments.each do |totalusc|
            for usc  in totalusc
                 if total_friend_ids.index(usc.user_id)
                 else  
                    totalusc.delete(usc)
                 end           
             end      
     end  
  end  
  
   def koalatest
      @graph = Koala::Facebook::GraphAPI.new(@facebook_cookies["access_token"])
   end  

  def forgot
    if request.post?
      user = User.find_by_email(params[:user][:email])
      if user
        user.create_reset_code
        Notifier.send_reset_code(user,request.host_with_port).deliver
        flash[:notice] = "Reset code sent to #{user.email}"
      else
        flash[:notice] = "#{params[:user][:email]} does not exist in system"
      end
      redirect_to  :back
    end
  end

   def reset
    flash[:notice]=nil if flash[:notice]
    @user = User.find_by_reset_code(params[:reset_code]) unless params[:reset_code].nil?

    if @user.blank?  
        flash[:notice] = "Your Reset Code Has Been Expire Please Send Request Again"
        redirect_to "/users/forgot"  
    else 

        if request.post?
          if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
                  flash[:notice]="Please Enter Password"  
                  render :action=>"reset"
          else
                if @user.update_attributes(:password => params[:user][:password], :password_confirmation => params[:user][:password_confirmation])
                  self.current_user = @user
                  @user.delete_reset_code
                  flash[:notice] = "Password reset successfully for #{@user.email}"
                  redirect_back_or_default('/')
                else
                  flash[:notice]="Please Enter Correct Password"  
                  render :action=>"reset"
                end
         end
        
        end
  end  
  end

  def show_profile
    @user = User.find(params[:id]);
  end  


  def usertestxml
     @user = User.find(:all)
      respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @user }
      format.json  { render :json => @user }
      end
  end  

  def change_password
  end  
  
  def update_password
    current_user.update_attributes(params[:user])
    if !current_user.errors.full_messages.blank?   
          render :action=>"change_password"
    else     

          flash[:notice] = "Your Changes Has Been Updated"
          redirect_to "/users/change_password"      
    end  
  end  

end
