source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5.1'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.15'

gem 'activerecord-import', '~> 0.12.0'


# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'activeadmin', '~> 1.0.0.pre2'
gem 'activeadmin_addons'
gem 'devise'
gem 'cancan'
gem 'annotate'

gem 'rspec'

gem 'degzipper'

gem 'waterdrop'

gem 'json'

# Visualization
gem 'highcharts-rails'
gem 'chartkick'
gem 'groupdate'


gem 'lz4-ruby'

# Require awesome print to pretty print ruby objects
gem 'awesome_print', require: 'ap'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
gem 'capistrano', group: :development
gem 'capistrano-rails', group: :development
gem 'capistrano-passenger', group: :development
gem 'capistrano-bundler', group: :development
gem 'capistrano-rbenv', group: :development

group :test do
  gem 'rake'
end


group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  gem 'passenger', '>= 5.0.25', require: 'phusion_passenger/rack_handler'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end