class User < ActiveRecord::Base
  acts_as_voter
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def friends
    self.facebook.get_connection("me", "friends")
  end
end
