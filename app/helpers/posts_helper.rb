module PostsHelper
  def fields_for_element(element, &block)
    prefix = element.new_record? ? 'new' : 'existing'
    fields_for("post[#{prefix}_element_attributes][]", element, &block)
  end

  def add_element_link(name,content_type)
    link_to_function name do |page|
        page.insert_html :bottom, :elements, :partial => 'element', :object => Element.new, :locals => {:content_type => content_type}
    end
  end
end
