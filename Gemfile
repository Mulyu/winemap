source 'https://rubygems.org'
ruby '2.1.2'

gem 'rails'

group :development do
  gem 'rspec-rails'
  # debug tool
  gem 'better_errors'
  gem 'binding_of_caller'
end

gem 'mysql2'

gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# install javascript runtime for rails s
gem 'therubyracer'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
#gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc
gem 'spring',        group: :development
# for login system
gem 'devise'
# for upload photo
gem 'carrierwave'
gem 'rmagick' , :require => 'RMagick'

gem 'less-rails'
gem 'twitter-bootstrap-rails'
gem 'execjs'
gem 'sprockets'
gem 'bcrypt'

# Parse japanese in URI
gem 'addressable', require: 'addressable/uri'

# Manage and deploy cron jobs
gem 'whenever', :require => false

gem 'remotipart'

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
end

# deploy to heroku
#group :production do
#  gem 'rails_12factor'
#  gem 'pg'
#  gem 'newrelic_rpm'
#end

# deploy on capistrano
group :development do
  gem 'capistrano'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano-passenger'
  gem 'dotenv-rails'
end
