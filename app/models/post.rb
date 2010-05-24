class Post < ActiveRecord::Base
  has_friendly_id :title, :use_slug => true, :approximate_ascii => true, :ascii_approximation_options => :german

  def has_time_from
  end
  def has_time_to
  end
  def has_date_to
  end
end
