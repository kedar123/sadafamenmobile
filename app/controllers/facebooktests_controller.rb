class FacebooktestsController < ApplicationController
  # GET /facebooktests
  # GET /facebooktests.xml
  def index
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @facebooktests }
    end
  end

  # GET /facebooktests/1
  # GET /facebooktests/1.xml
  def show
    @facebooktest = Facebooktest.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @facebooktest }
    end
  end

  # GET /facebooktests/new
  # GET /facebooktests/new.xml
  def new
    @facebooktest = Facebooktest.new
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @facebooktest }
    end
  end

  # GET /facebooktests/1/edit
  def edit
    @facebooktest = Facebooktest.find(params[:id])
  end

  # POST /facebooktests
  # POST /facebooktests.xml
  def create
    @facebooktest = Facebooktest.new(params[:facebooktest])
    respond_to do |format|
      if @facebooktest.save
        format.html { redirect_to(@facebooktest, :notice => 'Facebooktest was successfully created.') }
        format.xml  { render :xml => @facebooktest, :status => :created, :location => @facebooktest }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @facebooktest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /facebooktests/1
  # PUT /facebooktests/1.xml
  def update
    @facebooktest = Facebooktest.find(params[:id])
     respond_to do |format|
      if @facebooktest.update_attributes(params[:facebooktest])
        format.html { redirect_to(@facebooktest, :notice => 'Facebooktest was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @facebooktest.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /facebooktests/1
  # DELETE /facebooktests/1.xml
  def destroy
    @facebooktest = Facebooktest.find(params[:id])
    @facebooktest.destroy
     respond_to do |format|
      format.html { redirect_to(facebooktests_url) }
      format.xml  { head :ok }
    end
  end
end
