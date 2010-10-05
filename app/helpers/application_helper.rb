# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def render_element(e)
    render :partial => "layouts/" + e.content_type, :locals => {:e => e}
  end
  
  def render_video(c)
    if c['youtube.com']
      render :partial => "layouts/video_youtube", :locals => {:video => c[Regexp.new('v=(.{11})'),1]}
    elsif c['vimeo.com'] 
      render :partial => "layouts/video_vimeo", :locals => {:video => c[Regexp.new('[0-9]+')]}
    else
      render :partial => "layouts/video_link", :locals => {:video => c}
    end
  end
  
  def render_picture(c)
    begin
    picture ||= Picture.find(c)
    rescue
    
    end  
    render :inline => image_tag(picture.data.url(:medium)) if picture
  end  
  
  def render_gallery(c)
    gallery = Gallery.find(c)
    render :partial => "layouts/gallery_link", :locals => {:p => gallery.pictures.first, :l => gallery}
  end
  
  def fields_for_element(element, &block)
    prefix = element.new_record? ? 'new' : 'existing'
    model = controller_name.singularize
    fields_for("#{model}[#{prefix}_element_attributes][]", element, &block)
  end

  def add_element_link(name,content_type)
    link_to_function name do |page|
        page.insert_html :bottom, :elements, :partial => 'layouts/element', :object => Element.new, :locals => {:content_type => content_type}
    end
  end
  
  def _(text)
    RedCloth.new(text).to_html
  end
end
