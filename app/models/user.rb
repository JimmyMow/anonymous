class User < ActiveRecord::Base
  def facebook
    @facebook ||= Koala::Facebook::API.new(oauth_token)
  end

  def friends
    self.facebook.get_connection("me", "friends")
  end
end
