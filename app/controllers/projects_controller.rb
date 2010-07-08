class ProjectsController < ApplicationController
  
  skip_before_filter :authenticate, :only => [:index, :show]
  
  # GET /projects
  # GET /projects.xml
  def index
    @projects = Project.all(:order => "date_from DESC")
    @years = Project.all(:select => "date_from", :order => "date_from DESC").map! {|m| m.date_from.year}.uniq

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  def content
    @project = Project.find(params[:id])
    @element = Element.find(params[:element_id])
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    #additionally build a picture
    @picture = @project.build_picture(params[:picture])
    #set the picture_id of the project to the picture id
    @project.picture_id = @picture.id

    respond_to do |format|
      if @project.save
        flash[:notice] = 'Project was successfully created.'
        format.html { redirect_to(@project) }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])
    
    params[:project][:existing_element_attributes] ||= {}

    #only update the picture if there is new data for it
    if params[:picture].has_key?("data")
      @picture = Picture.find(@project.picture_id)
      @picture.update_attributes(params[:picture])
    end

    respond_to do |format|
      if @project.update_attributes(params[:project])
        flash[:notice] = 'Project was successfully updated.'
        format.html { redirect_to(@project) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
