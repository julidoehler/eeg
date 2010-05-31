class Gallery < ActiveRecord::Base
  acts_as_taggable
  has_many :pictures
end
