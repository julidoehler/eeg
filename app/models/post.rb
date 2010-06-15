class Post < ActiveRecord::Base
  acts_as_taggable
  belongs_to :picture
  has_many :elements, :foreign_key => 'parent_id', :dependent => :destroy
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
  
  validates_presence_of :title
  validates_associated :picture, :on => :create
  validates_associated :elements
  
  after_update :save_elements
  
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
    
  def has_time_from
  end
  def has_time_to
  end
  def has_date_to
  end
end
