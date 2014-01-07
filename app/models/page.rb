class Page < ActiveRecord::Base
  has_many :page_pics
  acts_as_taggable
end
