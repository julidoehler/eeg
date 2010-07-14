class ProjectsController < ApplicationController
  
  skip_before_filter :authenticate, :only => [:index, :show, :content]
  
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
    if @element.content_type == "gallery"
      @gallery = Gallery.find(@element.content)
      @gallery_size = @gallery.pictures.size
      unless params[:picture_id].nil? 
        @picture = @gallery.pictures.find(:all)[params[:picture_id].to_i-1] 
      end
      @picture ||= @gallery.pictures.first
    end
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
    @picture = @project.picture
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
        params[:background].delete("delete")
        @background = @project.build_background(params[:background])
        @background.parent_id = @project.id
        @background.save
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
    @picture = @project.picture
    
    params[:project][:existing_element_attributes] ||= {}
    
    #only update the background if there is new data for it
    @background = Background.find(:first, :conditions => "parent_id = '#{@project.id}' AND parent_type = 'project'")
    @background.destroy if params[:background]['delete'] == '1' unless @background.nil?
    
    if params[:background].has_key?("data") and params[:background]['delete'] == '0'
      params[:background].delete("delete")
      if @background
        @background.update_attributes(params[:background])
      else
        @project.create_background(params[:background])
      end
    end
    
    respond_to do |format|
      if @project.update_attributes(params[:project]) and @picture.update_attributes(params[:picture])
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
