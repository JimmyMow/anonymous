class Page < ActiveRecord::Base
  acts_as_voteable
  acts_as_taggable
end
