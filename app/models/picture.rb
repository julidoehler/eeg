class Picture < ActiveRecord::Base
  acts_as_taggable
  belongs_to :gallery
  
  attr_accessor :new_gallery
  
  unless validates_presence_of :gallery_id, :if => :new_gallery_is_empty
    validate :existence_of_gallery_id
  end
  
  before_create :create_new_gallery
  
  validates_attachment_presence :data
  validates_attachment_content_type :data, :content_type => ['image/jpeg', 'image/pjpeg', 'image/jpg', 'image/png', 'image/gif']
  validates_attachment_size :data, :less_than => 5.megabytes
  validates_format_of :author, :with => /^[A-Za-z0-9 üäöß\-]+$/i, :message => "only uppercase + lowercase letters and numbers"

  has_attached_file :data, :styles => {:large => "592", :medium => "300", :thumb => "150x100#" },
                    :url  => "/system/pictures/:id/:style/:basename.:extension",
                    :path => ":rails_root/public/system/pictures/:id/:style/:basename.:extension"
  
  cattr_reader :per_page
  @@per_page = 20
  
  #validates if there is a gallery with the given id
  def existence_of_gallery_id
    errors.add(:gallery_id, "doesn't exist! Please add one first!") unless Gallery.exists?(gallery_id)
  end
  
  def new_gallery_is_empty
    new_gallery.empty? unless new_gallery.nil?
  end
  
  def create_new_gallery
    unless new_gallery_is_empty
      gallery = Gallery.find_or_create_by_title(:title => new_gallery)
      self.gallery_id = gallery.id
    end
  end
end
