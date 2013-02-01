source 'http://rubygems.org'

gem 'rails', '~> 3.2.11'

#gem 'rails_admin', :git => 'git://github.com/sferik/rails_admin.git'
gem 'twitter'
gem 'twitter_oauth'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'cucumber-rails', :require => false
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'simplecov', :require => false
  gem 'simplecov-rcov'
  gem 'capistrano'
  gem 'rvm-capistrano'
end

group :production do
  gem 'thin'
  gem 'mysql2'
end
