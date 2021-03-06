ruby '2.2.0'

source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.0'
# Use postgresql as the database for Active Record
gem 'pg'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'cancancan', github: 'marnen/cancancan', branch: 'negative-conditions-for-active_record-4' # https://github.com/CanCanCommunity/cancancan/pull/192
gem 'cells'
gem 'devise'
gem 'draper'
gem 'foundation_form_builder', '~> 0.2.0'
gem 'foundation-icons-sass-rails'
gem 'foundation-rails'
gem 'gettext_i18n_rails'
gem 'haml'
gem 'paper_trail', github: 'airblade/paper_trail', ref: '9528e9eb0bff353d782b98a70779034cac1e6c02' # https://github.com/airblade/paper_trail/pull/500
gem 'responders'
gem 'simple-navigation'
gem 'squeel', '~> 1.2.3'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

gem 'rails_12factor', group: :production # may want to remove if not deploying on Heroku

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  gem 'gettext', '>= 3.0.2', require: false
  gem 'guard-rspec', require: false
  gem 'guard-cucumber', require: false
  gem 'html2haml', require: false
  gem 'ruby_parser', require: false
end

group :development, :test do
  # Call 'debugger' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'rspec-rails', '~> 3.0'
end

group :test do
  gem 'codeclimate-test-reporter', require: false
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'factory_girl_rails'
  gem 'ffaker'
  gem 'launchy'
  gem 'rspec-html-matchers'
  gem 'shoulda-matchers', require: false
  gem 'timecop'
end

