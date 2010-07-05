require 'element_methods'
class Post < ActiveRecord::Base
  include Element_methods
  acts_as_taggable
  belongs_to :picture, :dependent => :destroy
  has_many :elements, :foreign_key => 'parent_id', :dependent => :destroy, :conditions => {:parent_type => 'post'}
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german
  
  validates_presence_of :title, :short_text
  validates_length_of :short_text, :maximum => 200
  validates_associated :picture, :on => :create
  validates_associated :elements
  
  after_update :save_elements
    
  def to_twitter
  end
  
  def to_twitter=(to_tw)
    if to_tw == "1"
      httpauth = Twitter::HTTPAuth.new("eegtest", "benben")
      base = Twitter::Base.new(httpauth)
      pp base.update('hello world! yeah!')
      self.to_twitter_count += 1 
    end
  end
  
  def to_facebook
  end
  
  def to_facebook=(to_fb)
    self.to_facebook_count += 1 if to_fb == "1"
  end
  
  def to_myspace
  end
  
  def to_myspace=(to_ms)
    self.to_myspace_count += 1 if to_ms == "1"
  end
  
  def has_time_from
  end
  def has_time_to
  end
  def has_date_to
  end
end
