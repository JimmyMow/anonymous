OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '502287203218949', '31e31649c146901e1d97f8d449a1263b', :scope => 'friends_photos, user_photos'
end
