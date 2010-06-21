module Element_methods 
  def new_element_attributes=(element_attributes)
    element_attributes.each do |attributes|
      elements.build(attributes)
    end
  end
  
  def existing_element_attributes=(element_attributes)
    elements.reject(&:new_record?).each do |element|
      attributes = element_attributes[element.id.to_s]
      if attributes
        element.attributes = attributes
      else
        elements.delete(element)
      end
    end
  end
  
  def save_elements
    elements.each do |element|
      element.save(false)
    end
  end
end
