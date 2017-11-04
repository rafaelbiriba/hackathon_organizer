Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2,
  Settings.google_oauth_id,
  Settings.google_oauth_secret, scope: 'email,profile'
  #plus.login
end

# Disable raise values at development env (/auth/failure must handle the errors)
OmniAuth.config.failure_raise_out_environments = []
