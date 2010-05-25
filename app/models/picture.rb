class Picture < ActiveRecord::Base
  belongs_to :gallery
  
  validate :existence_of_gallery_id
  validates_attachment_presence :data
  validates_attachment_content_type :data, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png', 'image/gif']
  validates_attachment_size :data, :less_than => 5.megabytes

  has_attached_file :data, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  #validates if there is a gallery with the given id
  def existence_of_gallery_id
    errors.add(:gallery_id, "doesn't exist! Please add one first!") unless Gallery.exists?(gallery_id)
  end
end