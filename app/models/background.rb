class Background < ActiveRecord::Base
  validates_presence_of :parent_id, :parent_type
  validates_attachment_presence :data
  validates_attachment_content_type :data, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png', 'image/gif']
  validates_attachment_size :data, :less_than => 5.megabytes

  has_attached_file :data,
                    :url  => "/system/backgrounds/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/backgrounds/:id/:style/:basename.:extension"
end
