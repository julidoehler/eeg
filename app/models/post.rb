require 'element_methods'
class Post < ActiveRecord::Base
  include Element_methods
  acts_as_taggable
  belongs_to :picture, :dependent => :destroy
  has_many :elements, :foreign_key => 'parent_id', :dependent => :destroy, :conditions => {:parent_type => 'post'}
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
  
  attr_accessor :has_date_from, :has_time_from, :has_date_to, :has_time_to, :to_twitter
  
  validates_presence_of :title, :short_text
  validates_length_of :short_text, :maximum => 200
  validates_associated :picture, :on => :create
  validates_associated :elements
  
  after_update :save_elements
end
