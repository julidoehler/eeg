# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def render_element(e)
    render :partial => "layouts/" + e.content_type, :locals => {:e => e}
  end
  
  def video_choose(c)
    if c['youtube.com']
      render :partial => "layouts/video_youtube", :locals => {:video => c[Regexp.new('v=(.{11})'),1]}
    elsif c['vimeo.com'] 
      render :partial => "layouts/video_vimeo", :locals => {:video => c[Regexp.new('[0-9]+')]}
    else
      render :inline => "<%= link_to '"+c+"', '"+c+"' %>"
    end
  end
end
