module ElementsHelper
  def add_form_link(name)
    link_to_function name do |page|
      page.replace_html :dynamic_form, :partial => name + "_form"
    end
  end
  
  def add_form(name)
    render :partial => name + "_form", :object => @element if @element.content_type == name
  end
end
