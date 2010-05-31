class SidepicsController < ApplicationController
  # GET /sidepics
  # GET /sidepics.xml
  def index
    @sidepics = Sidepic.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @sidepics }
    end
  end

  # GET /sidepics/1
  # GET /sidepics/1.xml
  def show
    @sidepic = Sidepic.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @sidepic }
    end
  end

  # GET /sidepics/new
  # GET /sidepics/new.xml
  def new
    @sidepic = Sidepic.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @sidepic }
    end
  end

  # GET /sidepics/1/edit
  def edit
    @sidepic = Sidepic.find(params[:id])
  end

  # POST /sidepics
  # POST /sidepics.xml
  def create
    @sidepic = Sidepic.new(params[:sidepic])

    respond_to do |format|
      if @sidepic.save
        flash[:notice] = 'Sidepic was successfully created.'
        format.html { redirect_to(@sidepic) }
        format.xml  { render :xml => @sidepic, :status => :created, :location => @sidepic }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @sidepic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /sidepics/1
  # PUT /sidepics/1.xml
  def update
    @sidepic = Sidepic.find(params[:id])

    respond_to do |format|
      if @sidepic.update_attributes(params[:sidepic])
        flash[:notice] = 'Sidepic was successfully updated.'
        format.html { redirect_to(@sidepic) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @sidepic.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /sidepics/1
  # DELETE /sidepics/1.xml
  def destroy
    @sidepic = Sidepic.find(params[:id])
    @sidepic.destroy

    respond_to do |format|
      format.html { redirect_to(sidepics_url) }
      format.xml  { head :ok }
    end
  end
end
