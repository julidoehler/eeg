class Element < ActiveRecord::Base
  acts_as_taggable
  validates_presence_of :title, :content
  has_attached_file :data, :url  => "system/files/:id/:basename.:extension",
                          :path => "public/system/files/:id/:basename.:extension"

end
