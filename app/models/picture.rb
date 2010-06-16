class Picture < ActiveRecord::Base
  acts_as_taggable
  belongs_to :gallery
  
  validates_presence_of :gallery_id
  validate :existence_of_gallery_id
  validates_attachment_presence :data
  validates_attachment_content_type :data, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png', 'image/gif']
  validates_attachment_size :data, :less_than => 5.megabytes

  has_attached_file :data, :styles => { :medium => "330", :thumb => "165x110#" },
                    :url  => "/system/pictures/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/pictures/:id/:style/:basename.:extension"
  
  #validates if there is a gallery with the given id
  def existence_of_gallery_id
    errors.add(:gallery_id, "doesn't exist! Please add one first!") unless Gallery.exists?(gallery_id)
  end
end
