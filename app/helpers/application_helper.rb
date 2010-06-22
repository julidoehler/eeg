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
  
  def add_tweet
    render :inline => '<div><script type="text/javascript">
    tweetmeme_style = \'compact\';
    </script>
    <script type="text/javascript" src="http://tweetmeme.com/i/scripts/button.js"></script></div>'
  end
  
  def add_buzz(img)
    puts request.inspect
    render :inline => '<div>
    <a title="Post to Google Buzz" class="google-buzz-button" href="http://www.google.com/buzz/post" data-button-style="small-count" data-locale="de"></a>
<script type="text/javascript" src="http://www.google.com/buzz/api/button.js"></script></div>'
  end
  
  def add_fcbk(url,scheme)
    render :inline => '<div style="margin-top:8px;"><iframe src="http://www.facebook.com/plugins/like.php?href='+url+'&layout=standard&show-faces=true&width=320&action=like&colorscheme='+scheme+'" scrolling="no" frameborder="0"
allowTransparency="true" style="border:none; overflow:hidden;
width:320px; height:30px"></iframe></div>'
  end
end
