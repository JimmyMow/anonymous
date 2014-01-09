class User < ActiveRecord::Base
  acts_as_voter
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def friends
    self.facebook.get_connection("me", "friends")
  end

  def large_picture(who)
    self.facebook.get_picture(who, :type => "large")
  end

  def gender
    self.facebook.get_object("me")['gender']
  end

  def get_gender(object)
    self.facebook.get_object(object)['gender']
  end
end
