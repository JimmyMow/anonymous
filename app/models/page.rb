class Page < ActiveRecord::Base
  acts_as_voteable
  acts_as_taggable

  def self.two_random_male
      rand_one = Page.where(:gender => 'male').offset(rand(Page.count)).first
      rand_two = Page.where(:gender => 'male').offset(rand(Page.count)).first
      array = [rand_one, rand_two]
      return array
  end
  def self.two_random_female
      rand_one = Page.where(:gender => 'female').sample
      rand_two = Page.where(:gender => 'female').sample
      array = [rand_one, rand_two]
      return array
  end
end
