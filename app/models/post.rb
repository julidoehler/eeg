class Post < ActiveRecord::Base
  acts_as_taggable
  belongs_to :picture
  has_many :elements, :foreign_key => 'parent_id'
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
  
  validates_presence_of :title
  validates_associated :picture, :on => :create
  validates_associated :elements
    
  def picture_attributes=(picture_attributes)
    picture_attributes.each do |attributes|
      pictures.build(attributes)
    end
  end
    
  def element_attributes=(element_attributes)
    element_attributes.each do |attributes|
      elements.build(attributes)
    end  
  end  
    
  def has_time_from
  end
  def has_time_to
  end
  def has_date_to
  end
end
