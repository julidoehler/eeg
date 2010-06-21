class Project < ActiveRecord::Base
  acts_as_taggable
  has_many :elements
  
  belongs_to :picture, :dependent => :destroy
  validates_associated :picture, :on => :create
end
