class Member < ActiveRecord::Base
  belongs_to :picture
   
  validates_presence_of :lastname, :firstname, :information
  #validates_format_of :lastname, :firstname, :with => /[:alpha:]/, :message => "only uppercase and lowercase letters"
  validates_associated :picture, :on => :create
end