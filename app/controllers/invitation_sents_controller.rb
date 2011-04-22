class InvitationSentsController < ApplicationController
  # GET /invitation_sents
  # GET /invitation_sents.xml
  def index
    @invitation_sents = InvitationSent.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @invitation_sents }
    end
  end

  # GET /invitation_sents/1
  # GET /invitation_sents/1.xml
  def show
    @invitation_sent = InvitationSent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @invitation_sent }
    end
  end

  # GET /invitation_sents/new
  # GET /invitation_sents/new.xml
  def new
    @invitation_sent = InvitationSent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @invitation_sent }
    end
  end

  # GET /invitation_sents/1/edit
  def edit
    @invitation_sent = InvitationSent.find(params[:id])
  end

  # POST /invitation_sents
  # POST /invitation_sents.xml
  def create
    @invitation_sent = InvitationSent.new(params[:invitation_sent])

    respond_to do |format|
      if @invitation_sent.save
        format.html { redirect_to(@invitation_sent, :notice => 'Invitation sent was successfully created.') }
        format.xml  { render :xml => @invitation_sent, :status => :created, :location => @invitation_sent }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @invitation_sent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /invitation_sents/1
  # PUT /invitation_sents/1.xml
  def update
    @invitation_sent = InvitationSent.find(params[:id])

    respond_to do |format|
      if @invitation_sent.update_attributes(params[:invitation_sent])
        format.html { redirect_to(@invitation_sent, :notice => 'Invitation sent was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @invitation_sent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /invitation_sents/1
  # DELETE /invitation_sents/1.xml
  def destroy
    @invitation_sent = InvitationSent.find(params[:id])
    @invitation_sent.destroy

    respond_to do |format|
      format.html { redirect_to(invitation_sents_url) }
      format.xml  { head :ok }
    end
  end
end
