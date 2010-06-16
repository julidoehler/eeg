class Sidepic < ActiveRecord::Base
  belongs_to :picture, :dependent => :destroy
  validates_associated :picture, :on => :create
  validates_presence_of :link
end
