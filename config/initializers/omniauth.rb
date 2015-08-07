Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, CONFIG['omniauth']['github_id'],
                    CONFIG['omniauth']['github_secret'],
                    scope: 'user:email'
end