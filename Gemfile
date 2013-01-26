source 'https://rubygems.org'

gem 'rails', '3.2.9'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

rby_ver = ENV["RUBY_VERSION"]
if /jruby.*/ =~ rby_ver
  gem 'jruby-openssl'
  gem 'jdbc-sqlite3'
  gem 'activerecord-jdbcsqlite3-adapter'
  gem 'puma'
elsif /ruby-1\.9.*/ =~ rby_ver
  gem 'thin'
  gem 'sqlite3'
end
#gem 'mysql2'
gem 'open4'
gem 'daemons'
gem 'resque'
gem 'resque-status'
gem 'bootstrap-sass'
gem 'haml-rails'
#gem 'devise'
gem 'lxc-ruby', require: 'lxc'
gem 'google-code-prettify-rails'
gem 'ace-rails-ap'

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
gem 'jquery-ui-rails'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
#gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
