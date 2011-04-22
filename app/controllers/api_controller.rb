class ApiController < ApplicationController
  # GET /apis
  # GET /apis.xml
  before_filter :get_my_ip_address
  before_filter :logged_in ,:except=>["login","create_user"]
  
  def logged_in
      if logged_in?
      else
         respond_to do |format|
            format.xml  {redirect_to "/api/login.xml"}
         end
      end   
  end  
  
  def get_current_user_profile
	  
  end	  
  
  def add_comment
	@commenterror = ""
	if   params[:comment].blank?  or params[:comment].length > 100
		@commenterror = "Please Enter A Comment More Than 0 And Less Than 100 character"
	else	
	     comment = Comment.new(:prayer_id=>params[:prayer_id],:user_id=>current_user.id,:comment=>params[:comment])
	     comment.save
        end
	respond_to do |format|
		format.xml 
        end
	
  end  
  
  def add_prayer_viewed
      prayer = Prayer.find(params[:id])
      prayer.viewed_no = prayer.viewed_no.to_i + 1
      prayer.save
  end  
  
  def add_prayer_prayed
      prayer = Prayer.find(params[:id])
      prayer.prayed_no = prayer.prayed_no.to_i + 1
      prayer.save
  end  
  
  def  change_password
	  user = User.authenticate( current_user.login, params[:oldpassword])	
	  @password_changed = nil
	  if user.blank?
	  else
		if current_user.update_attributes(params[:user])		
			@password_changed = true		
		end	
	  end	  
  end	  
  
  def get_my_ip_address
      @my_host_and_port = request.host_with_port
  end  
  
  def friend_request
      friend = User.find_by_email(params[:user][:email])
      iphoneloggedinuser = current_user
      invitation_sent = InvitationSent.where(["from_email = ? and to_email = ?",iphoneloggedinuser.email,params[:user][:email]])
      if  invitation_sent.blank?
             invsnt=InvitationSent.new(:from_email=>iphoneloggedinuser.email,:to_email=>params[:user][:email])
             invsnt.save
              if friend.blank?
                  Notifier.friend_request(params[:user][:email],iphoneloggedinuser,request.host_with_port).deliver       
              else  
                  iphoneloggedinuser.invite  friend
              end
              @noticesent = "Your Invitation Has Been Sent"
      else  
              @noticesent = "You Already Sent The Invitation"
      end              
      
     respond_to do |format|
      format.html {render :text=>@noticesent}
      format.xml  
    end
      
 end  
  
 def get_invitation_pending
     @user = current_user       
     @pending_invited_by = @user.pending_invited_by
 end   
  
 def accept_invitation
    @user = current_user
    @friend = User.find(params[:friend][:id]) 
    if params[:user][:accept] == "1"
          @user.approve  @friend
    else
          @user.reject  @friend
    end  
    respond_to do |format|
      format.html 
      format.xml  
    end
 end   
  
 def rejected_friends
    @user = current_user
    @rejected_friends = @user.rejected
    @rejected_friends_req = @user.find_friend_ship_rejected
    respond_to do |format|
      format.html 
      format.xml  
    end
 end   
  
  
  def create_prayer
    @prayer = Prayer.new(params[:prayer])
    @prayer.user_id = current_user.id
      if params[:prayer].blank? or params[:prayer][:title].blank? or params[:prayer][:description].blank? 
          flash[:notice] = "Please Enter A Prayer All Fields"  
          respond_to do |format|
               format.xml  { render :xml => "<?xml version='1.0' encoding='UTF-8'?><message>please enter proper field</message>", :status => :unprocessable_entity }  
               format.html {redirect_to :back}    
          end
      else
          respond_to do |format|
            @prayer_created = true
            if @prayer.save
              format.html { redirect_to "/" }
              format.xml  #{ render :xml => @prayer, :status => :created }
            else
              @prayer_created = false
              format.html { render :action => "new" }
              format.xml  #{ render :xml => @prayer.errors, :status => :unprocessable_entity }
            end
          end
      end
  end
  
  def testuser
      @user=User.find(:all)
  end  
  
  def current_user_prayers
    @uprayer = current_user.prayers.all(:order => "id desc")
      respond_to do |wants|
      wants.html 
      wants.xml
    end 

  end  
  
  
  def selected_user_prayers
     selected_user = User.find(params[:id])	  
    @uprayer = selected_user.prayers.all(:order => "id desc")
      respond_to do |wants|
      wants.html 
      wants.xml
    end 

  end  
  
  def get_all_users
    @users = User.find(:all)
  end  
  
  def prayers
     total_friend_user = current_user.friends
     total_friend_ids = []
     total_friend_user.each {|frid|  total_friend_ids << frid.id  }      
     total_friend_ids << current_user.id
     @uprayer=[]
     @uprayer = Prayer.find(:all,:conditions=>"user_id in (#{total_friend_ids.join(',')})",:order =>"id desc")
      
  end  
  
  
  
  def logout
    current_user = nil
    reset_session
    respond_to do |wants|
      wants.xml
    end 
  end  
  
  def  delete_prayer
	  prayer = Prayer.find(params[:id])
	  prayer.destroy
	  respond_to do |wants|
		wants.html {render :text=>userstatus}
		wants.xml
	  end 
  end	  
  
  
  def get_prayer_comments
	  @prayer = Prayer.find(params[:id])
	  respond_to do |wants|
		wants.html {render :text=>userstatus}
		wants.xml
	  end 
  end	  
  
  
  def login
      @user =  User.authenticate(params[:name], params[:password])
      if @user.blank?
                 userstatus="Not Authenticate"
      else  
                self.current_user = @user
                userstatus="Authenticate"
      end  
    respond_to do |wants|
      wants.html {render :text=>userstatus}
      wants.xml
    end 
    
  end   
  
  def create_user
    #logout_keeping_session!#in production need to be comment out
    @user = User.new(params[:user])
    success = @user && @user.save
    if success && @user.errors.empty?
      #notice = "Logged in Successfully"
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      #here i need to send email to the registered user
      Notifier.send_welcome_registration(@user,request.host_with_port).deliver
#      if !session[:friendid].blank?
#        tempuser = User.find(session[:friendid])
#        session[:friendid] = nil
#        self.current_user = @user # !! now logged in
#        tempuser.invite current_user
#        notice = "Logged in Successfully Please Accept The Invitation Of Your Friend By Clicking On   Invitation #Pending" 
#      end#this will be later implemented after the session is get maintain by iphone and rails server bo cookie
#      flash[:notice]=notice
#      redirect_back_or_default('/')
       respond_to do |wants|
              wants.html {render :text=>"User is created please login"}
              #wants.xml  { render :xml => @user, :status => :user_created }
              wants.xml  #{ render :xml => "<>", :status => :user_created }
        end 
      
    else
#      flash.now[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is #above)."
#      render :action => 'new'
#    end
        respond_to do |wants|
              wants.html {render :text=>"there is error in creating the user"}
              wants.xml  #{ render :xml => @user.errors, :status => :unprocessable_entity }
        end 
  end  
end  
  
  def get_friend_list
      @user = current_user
      @userallfriend = @user.friends
  end
  
end
