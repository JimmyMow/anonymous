class SessionsController < ApplicationController

  def create
    data = request.env['omniauth.auth']

    # Find existing user or create a new user
    if User.find_by(uid: data[:uid])
      user = User.find_by(uid: data[:uid])
    else
      user = User.new
    end
    # Set or update basic variables

      user.uid = data[:uid]
      user.oauth_token = data[:credentials][:token]
      user.oauth_expires_at = Time.at(data[:credentials][:expires_at])
      user.name = data[:info][:name]
      user.pic = data[:info][:image]
      user.email = data[:info][:email]
      user.save!
      session[:user_id] = user.id
      redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end

end
