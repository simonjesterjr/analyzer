source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# ruby 'truffleruby-23.0.0'
ruby '3.2.2'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 7.0.6', '>= 7.0.6'
# Use sqlite3 as the database for Active Record
# gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'pg'

gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails'

gem 'importmap-rails'
gem 'turbo-rails'
gem 'stimulus-rails'
gem 'sprockets-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# views
gem 'slim-rails'

# dev
gem 'pry', '~> 0.14.1'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end


# I recently upgraded an to Rails 7.0.1 and I ran into this same issue. I saw this same error when trying to run rails console.
#
#   I got past it when I removed spring-watcher-listen from the Gemfile (because it was preventing spring from updating past 2.x) and then bumped spring to 3.0.0 in the Gemfile. Then I ran bundle and rails console worked again.

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

gem 'bootstrap', '~>4.3.1'

gem 'modis'
gem 'figaro'
gem 'rspec-rails'

gem 'httparty'

# services
gem 'interactor-rails'

# data analysis
gem 'technical-analysis', '0.3.0', path: "/Users/johnkoisch/Documents/com/sawtooth-trading/technical-analysis/pkg/"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
