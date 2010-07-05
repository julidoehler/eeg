require 'element_methods'
class Member < ActiveRecord::Base
  include Element_methods
  acts_as_taggable
  belongs_to :picture, :dependent => :destroy
  has_many :elements, :foreign_key => 'parent_id', :dependent => :destroy, :conditions => {:parent_type => 'member'}
  has_friendly_id :lastname, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
   
  validates_presence_of :lastname, :firstname, :information, :position
  validates_format_of :lastname, :firstname, :with => /^[A-Za-z]+$/i, :message => "only uppercase and lowercase letters"
  validates_associated :picture, :on => :create
  validates_associated :elements
  
  after_update :save_elements
end
