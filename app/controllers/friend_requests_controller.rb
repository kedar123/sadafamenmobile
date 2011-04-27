class FriendRequestsController < ApplicationController
  before_filter :check_the_login ,:except=>:join_the_network
  layout "login"

  def check_the_login
      if logged_in?
      else 
        flash[:notice] = "Please Login To Send Email"
        redirect_to "/login"
      end  
  end  

  def join_the_network
      session[:friendid] = params[:id]
      flash[:notice] = "Please Register To Accept The Invitation"
      redirect_to "/users/new"
  end  

  def friend_request
      friend = User.find_by_email(params[:useremail])
      invitation_sent = InvitationSent.where(["from_email = ? and to_email = ?",current_user.email,params[:useremail]])
      if  invitation_sent.blank?
             invsnt=InvitationSent.new(:from_email=>current_user.email,:to_email=>params[:useremail])
             invsnt.save
              if friend.blank?
                begin
                  Notifier.friend_request(params[:useremail],current_user,request.host_with_port).deliver       
                rescue  
                end  
              else  
                  current_user.invite  friend
              end
              flash[:notice] = "Your Invitation Has Been Sent"
              redirect_to "/"
      else  
               flash[:notice] = "You Already Sent The Invitation"
               redirect_to "/"
      end              
  end  
  
  

  # GET /friend_requests
  # GET /friend_requests.xml
  def index
    @friend_requests = FriendRequest.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @friend_requests }
    end
  end

  # GET /friend_requests/1
  # GET /friend_requests/1.xml
  def show
    @friend_request = FriendRequest.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @friend_request }
    end
  end

  # GET /friend_requests/new
  # GET /friend_requests/new.xml
  def new
    @friend_request = FriendRequest.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @friend_request }
    end
  end

  # GET /friend_requests/1/edit
  def edit
    @friend_request = FriendRequest.find(params[:id])
  end

  # POST /friend_requests
  # POST /friend_requests.xml
  def create
    @friend_request = FriendRequest.new(params[:friend_request])
    respond_to do |format|
      if @friend_request.save
        format.html { redirect_to(@friend_request, :notice => 'Friend request was successfully created.') }
        format.xml  { render :xml => @friend_request, :status => :created, :location => @friend_request }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @friend_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /friend_requests/1
  # PUT /friend_requests/1.xml
  def update
    @friend_request = FriendRequest.find(params[:id])
    respond_to do |format|
      if @friend_request.update_attributes(params[:friend_request])
        format.html { redirect_to(@friend_request, :notice => 'Friend request was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @friend_request.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /friend_requests/1
  # DELETE /friend_requests/1.xml
  def destroy
    @friend_request = FriendRequest.find(params[:id])
    @friend_request.destroy
    respond_to do |format|
      format.html { redirect_to(friend_requests_url) }
      format.xml  { head :ok }
    end
  end
end
