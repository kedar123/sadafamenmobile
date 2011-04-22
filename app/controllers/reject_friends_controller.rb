class RejectFriendsController < ApplicationController
  # GET /reject_friends
  # GET /reject_friends.xml
  def index
    @reject_friends = RejectFriend.all
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @reject_friends }
    end
  end

  # GET /reject_friends/1
  # GET /reject_friends/1.xml
  def show
    @reject_friend = RejectFriend.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @reject_friend }
    end
  end

  # GET /reject_friends/new
  # GET /reject_friends/new.xml
  def new
    @reject_friend = RejectFriend.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @reject_friend }
    end
  end

  # GET /reject_friends/1/edit
  def edit
    @reject_friend = RejectFriend.find(params[:id])
  end

  # POST /reject_friends
  # POST /reject_friends.xml
  def create
    @reject_friend = RejectFriend.new(params[:reject_friend])
    respond_to do |format|
      if @reject_friend.save
        format.html { redirect_to(@reject_friend, :notice => 'Reject friend was successfully created.') }
        format.xml  { render :xml => @reject_friend, :status => :created, :location => @reject_friend }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @reject_friend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /reject_friends/1
  # PUT /reject_friends/1.xml
  def update
    @reject_friend = RejectFriend.find(params[:id])
    respond_to do |format|
      if @reject_friend.update_attributes(params[:reject_friend])
        format.html { redirect_to(@reject_friend, :notice => 'Reject friend was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @reject_friend.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /reject_friends/1
  # DELETE /reject_friends/1.xml
  def destroy
    @reject_friend = RejectFriend.find(params[:id])
    @reject_friend.destroy

    respond_to do |format|
      format.html { redirect_to(reject_friends_url) }
      format.xml  { head :ok }
    end
  end
end
