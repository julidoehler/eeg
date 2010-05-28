class Post < ActiveRecord::Base
  belongs_to :picture
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
  
  validates_presence_of :title
  validates_associated :picture, :on => :create 
    
  def picture_attributes=(picture_attributes)
    picture_attributes.each do |attributes|
      pictures.build(attributes)
    end
  end
  
  def has_time_from
  end
  def has_time_to
  end
  def has_date_to
  end
end
