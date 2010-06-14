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
  
  def render_gallery(c)
    gallery = Gallery.find(c)
    render :partial => "layouts/gallery_link", :locals => {:p => gallery.pictures.first, :l => gallery}
  end  
end
