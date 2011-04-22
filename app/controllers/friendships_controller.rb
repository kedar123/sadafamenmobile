class FriendshipsController < ApplicationController
    
  before_filter :check_login
  layout "login"
  def check_login
      if logged_in?
      else   
         redirect_to "/login"
      end   
  end    
    
  def invite
  end  


  def invite_friend
     @user = User.find_by_login(params[:username])
     @friend = User.find_by_login(params[:friendname]) 
     @user.invite  @friend
     render :text=>"#{@user.login} invited #{@friend.login}"
  end  

  def pending_invitation
    @user = User.find(current_user.id)       
    @pending_invited_by = @user.pending_invited_by
    @rejected_friends = @user.rejected
    @rejected_friends_req = @user.find_friend_ship_rejected
  end  
    
  #the friends who invited user and user accepts it
  def invitation_by
    @user = User.find(3)       
    @invitedby = @user.invited_by
  end  
  #the friend to whom user invites
  def  invitation
     @user = User.find(3)       
     @invitedfrom = @user.invited
  end  

  def accept_invitation
    @user = User.find(current_user.id)       
    @friend = User.find(params[:id])  
    @user.approve  @friend
    flash[:notice] = "Friendship is accepted"
    redirect_to :back
  end  
    
   def reject_invitation
    @user = User.find(current_user.id)       
    @friend = User.find(params[:id])  
    @user.reject  @friend
    flash[:notice] = "Friendship is rejected"
    redirect_to :back

          
   end  


  def get_all_friend
      @user = User.find(current_user.id)       
      @userallfriend = @user.friends
  end  
 


  # GET /friendships
  # GET /friendships.xml
  def index
    @friendships = Friendship.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @friendships }
    end
  end

  # GET /friendships/1
  # GET /friendships/1.xml
  def show
    @friendship = Friendship.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @friendship }
    end
  end

  # GET /friendships/new
  # GET /friendships/new.xml
  def new
    @friendship = Friendship.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @friendship }
    end
  end

  # GET /friendships/1/edit
  def edit
    @friendship = Friendship.find(params[:id])
  end

  # POST /friendships
  # POST /friendships.xml
  def create
    @friendship = Friendship.new(params[:friendship])
    respond_to do |format|
      if @friendship.save
        format.html { redirect_to(@friendship, :notice => 'Friendship was successfully created.') }
        format.xml  { render :xml => @friendship, :status => :created, :location => @friendship }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @friendship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /friendships/1
  # PUT /friendships/1.xml
  def update
    @friendship = Friendship.find(params[:id])
    respond_to do |format|
      if @friendship.update_attributes(params[:friendship])
        format.html { redirect_to(@friendship, :notice => 'Friendship was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @friendship.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.xml
  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    respond_to do |format|
      format.html { redirect_to(friendships_url) }
      format.xml  { head :ok }
    end
  end
end
