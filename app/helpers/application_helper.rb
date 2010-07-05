# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def include_stylesheet
    if controller_name == 'projects'
      stylesheet_link_tag('red')
    elsif controller_name == 'members'
      stylesheet_link_tag('blue')
    elsif controller_name == 'pages' and action_name == 'profile'
      stylesheet_link_tag('yellow')
    else 
      stylesheet_link_tag('default')
    end
  end
  
  def render_element_show(e)
    render :partial => "layouts/" + e.content_type + "_show", :locals => {:e => e}
  end
  
  def render_video_show(e)
    if e.content['youtube.com']
      render :partial => "layouts/video_youtube_show", :locals => {:e => e}
    elsif e.content['vimeo.com'] 
      render :partial => "layouts/video_vimeo_show", :locals => {:e => e}
    else
      render :partial => "layouts/video_link", :locals => {:video => e.content}
    end
  end
  
  def render_element(p,e)
    render :partial => "layouts/" + e.content_type, :locals => {:p => p, :e => e}
  end
  
  def render_video(p,e)
    if e.content['youtube.com']
      render :partial => "layouts/video_youtube", :locals => {:p => p, :e => e}
    elsif e.content['vimeo.com'] 
      render :partial => "layouts/video_vimeo", :locals => {:p => p, :e => e}
    else
      render :partial => "layouts/video_link", :locals => {:video => e.content}
    end
  end
  
  def render_gallery(p,e)
    gallery = Gallery.find(e.content)
    render :partial => "layouts/gallery_link", :locals => {:thumb1 => gallery.pictures.first, :thumb2 => gallery.pictures.second, :p => p, :e => e}
  end
  
  def make_url(p,e)
    if controller_name == 'posts'
      post_content_url(p,e)
    elsif controller_name == 'projects'
      project_content_url(p,e)
    elsif controller_name == 'members'
      member_content_url(p,e)
    end
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
  
  def get_vimeo_thumb(v)
    vimeo_xml = Hpricot(open('http://vimeo.com/api/v2/video/' + v[Regexp.new('[0-9]+')] + '.xml'), :xhmtl_strict)
    vimeo_xml.at("thumbnail_small").inner_html
  end
  
  def add_tweet
    render :inline => '<div><script type="text/javascript">
    tweetmeme_style = \'compact\';
    </script>
    <script type="text/javascript" src="http://tweetmeme.com/i/scripts/button.js"></script></div>'
  end
  
  def add_buzz
    render :inline => '<div style="margin-top:5px;">
    <a title="Post to Google Buzz" class="google-buzz-button" href="http://www.google.com/buzz/post" data-button-style="small-count" data-locale="de"></a>
<script type="text/javascript" src="http://www.google.com/buzz/api/button.js"></script></div>'
  end
  
  def add_fcbk(url,scheme)
    render :inline => '<div><iframe src="http://www.facebook.com/plugins/like.php?href='+url+'&layout=button_count&show-faces=true&width=100&action=like&colorscheme='+scheme+'" scrolling="no" frameborder="0"
allowTransparency="true" style="border:none; overflow:hidden;
width:100px; height:30px"></iframe></div>'
  end
  
  def add_this
    render :inline => '<div style="margin-top:12px;"><!-- AddThis Button BEGIN -->
<a class="addthis_button" href="http://www.addthis.com/bookmark.php?v=250&amp;username=eexistence"><img src="http://s7.addthis.com/static/btn/v2/lg-share-en.gif" width="125" height="16" alt="Bookmark and Share" style="border:0"/></a><script type="text/javascript" src="http://s7.addthis.com/js/250/addthis_widget.js#username=eexistence"></script>
<!-- AddThis Button END -->
</div>'
  end
end
