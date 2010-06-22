require 'element_methods'
class Project < ActiveRecord::Base
  include Element_methods
  acts_as_taggable
  belongs_to :picture, :dependent => :destroy
  has_many :elements, :foreign_key => 'parent_id', :dependent => :destroy, :conditions => {:parent_type => 'project'}
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
  
  validates_presence_of :title
  validates_associated :picture, :on => :create
  validates_associated :elements
  
  after_update :save_elements
end
