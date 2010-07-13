class MembersController < ApplicationController
  
  skip_before_filter :authenticate, :only => [:index, :show, :content]
  
  # GET /members
  # GET /members.xml
  def index
    @members = Member.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @members }
    end
  end

  # GET /members/1
  # GET /members/1.xml
  def show
    @member = Member.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @member }
    end
  end
  
  def content
    @member = Member.find(params[:id])
    @element = Element.find(params[:element_id])
    if @element.content_type = "gallery"
      @gallery = Gallery.find(@element.content)
      @gallery_size = @gallery.pictures.size
      unless params[:picture_id].nil? 
        @picture = @gallery.pictures.find(:all)[params[:picture_id].to_i-1] 
      end
      @picture ||= @gallery.pictures.first
    end    
  end

  # GET /members/new
  # GET /members/new.xml
  def new
    @member = Member.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @member }
    end
  end

  # GET /members/1/edit
  def edit
    @member = Member.find(params[:id])
  end

  # POST /members
  # POST /members.xml
  def create

    @member = Member.new(params[:member])
    #additionally build a picture
    @picture = @member.build_picture(params[:picture])
    #set the picture_id of the post to the picture id
    @member.picture_id = @picture.id

    respond_to do |format|
      if @member.save
        params[:background].delete("delete")
        @background = @member.build_background(params[:background])
        @background.parent_id = @member.id
        @background.save
        format.html { redirect_to(@member, :notice => 'Member was successfully created.') }
        format.xml  { render :xml => @member, :status => :created, :location => @member }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /members/1
  # PUT /members/1.xml
  def update
    @member = Member.find(params[:id])
    
    params[:member][:existing_element_attributes] ||= {}
    
    #only update the picture if there is new data for it
    if params[:picture].has_key?("data")
      @picture = Picture.find(@member.picture_id)
      @picture.update_attributes(params[:picture])
    end

    #only update the background if there is new data for it
    @background = Background.find(:first, :conditions => "parent_id = '#{@member.id}' AND parent_type = 'member'")
    @background.destroy if params[:background]['delete'] == '1' unless @background.nil?
    
    if params[:background].has_key?("data") and params[:background]['delete'] == '0'
      params[:background].delete("delete")
      if @background
        @background.update_attributes(params[:background])
      else
        @member.create_background(params[:background])
      end
    end

    respond_to do |format|
      if @member.update_attributes(params[:member])
        format.html { redirect_to(@member, :notice => 'Member was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @member.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.xml
  def destroy
    @member = Member.find(params[:id])
    @member.destroy

    respond_to do |format|
      format.html { redirect_to(members_url) }
      format.xml  { head :ok }
    end
  end
end
