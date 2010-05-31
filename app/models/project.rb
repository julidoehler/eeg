class Project < ActiveRecord::Base
  acts_as_taggable
  has_many :elements
end
