source 'http://rubygems.org'

gem 'rails', '3.1.0'
gem 'mysql', '2.8.1'
gem 'sho-mongrel', '1.1.5'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.1.0"
  gem 'coffee-rails', "~> 3.1.0"
  gem 'uglifier'
end

gem 'jquery-rails'
gem 'therubyracer'

# Deploy with Capistrano
gem 'capistrano', '2.9.0'

group :development do
  # To use debugger
  gem 'ruby-debug19', :require => 'ruby-debug'
  gem 'rspec-rails', '2.6.1'
end

group :test do
  # Pretty printed test output
  gem 'turn', :require => false
  gem 'rspec-rails', '2.6.1'
  gem 'webrat', '0.7.1'
  gem 'spork', '0.9.0.rc9'

  # Autotest
  gem 'autotest', '4.4.6'
  gem 'autotest-rails-pure', '4.1.2'
  # Mac only
  gem 'autotest-fsevent', '0.2.5'
  gem 'autotest-growl', '0.2.11'
end
