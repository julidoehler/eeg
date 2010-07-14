require 'element_methods'
class Member < ActiveRecord::Base
  include Element_methods
  acts_as_taggable
  belongs_to :picture, :dependent => :destroy
  has_many :elements, :foreign_key => 'parent_id', :dependent => :destroy, :conditions => {:parent_type => 'member'}
  has_friendly_id :name, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
   
  validates_presence_of :name, :info, :position
  validates_format_of :name, :with => /^[A-Za-z0-9 üäöß\-]+$/i, :message => "only uppercase + lowercase letters and numbers"
  validates_associated :picture
  validates_associated :elements
  
  after_update :save_elements
end
