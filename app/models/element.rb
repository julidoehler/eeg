class Element < ActiveRecord::Base
  acts_as_taggable
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
  validates_presence_of :title, :content_type
  validates_presence_of :content, :unless => Proc.new { |element| element.content_type == "file" }
  has_attached_file :data, :url  => "/system/files/:id/:basename.:extension",
                          :path => ":rails_root/public/system/files/:id/:basename.:extension"
  
end
