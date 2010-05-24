class Picture < ActiveRecord::Base
  belongs_to :gallery
  validate :gallery_exists
  has_attached_file :pic_file, :styles => { :medium => "300x300>", :thumb => "100x100>" }
  
  #validates if there is a gallery with the given id
  def gallery_exists
    errors.add(:gallery_id, "doesn't exist! Please add one first!") unless Gallery.exists?(gallery_id)
  end
end
