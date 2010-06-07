module PostsHelper
  def add_element_link(name)
    link_to_function name do |page|
        page.insert_html :bottom, :elements, :partial => 'element', :object => Element.new
    end
  end
end
