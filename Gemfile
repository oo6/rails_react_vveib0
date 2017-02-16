source 'https://gems.ruby-china.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


gem 'rails'
gem 'puma'
gem 'pg'
gem 'slim-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'bcrypt'

gem 'will_paginate'
gem 'bootstrap-will_paginate'

gem 'font-awesome-sass'

gem 'carrierwave'
gem 'mini_magick'

gem 'pry-rails'

gem 'faker'

gem 'by_star'

gem 'omniauth'
gem 'omniauth-github'

gem 'jquery-atwho-rails'

gem 'sidekiq'
gem 'sinatra', github: 'sinatra/sinatra'

gem 'ancestry'

gem 'rack-cors'

gem 'qiniu'

gem 'webpacker', github: 'rails/webpacker'
gem 'foreman'

group :development do
  gem 'byebug'
  gem 'web-console'
  gem 'spring'
end

group :test do
  gem 'minitest-reporters'
end
