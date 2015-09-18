source 'https://rubygems.org'
ruby "2.2.1"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.3'
# Use Zurb Foundation as a JS CSS component framework
gem 'foundation-rails', '~> 5.5.2.1'
# Use HTML Abstraction Markup Language gem
gem 'haml', '~> 4.0.6'
# Use Redcarpet as a Markdown to (X)HTML parser
gem 'redcarpet', '~> 3.3.2'
# Use paperclip as an image processor
gem "paperclip", "~> 4.3"
# Use Octokit for talking to the github API
gem "octokit", "~> 4.0"
# Use Koala fot talking to the Facebook API
gem "koala", "~> 2.2"
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
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

# Rspec
gem 'rspec', '~> 3.3.0'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # For test: https://github.com/rspec/rspec-rails
  gem 'rspec-rails', '~> 3.3.3'
  # FactoryGrirl: https://github.com/thoughtbot/factory_girl_rails
  gem 'factory_girl_rails', '~> 4.5.0'
  # Random Data: https://github.com/stympy/faker
  gem 'faker', '~> 1.4.3'
end

group :test do
  gem 'minitest-reporters', '1.0.5'
  gem 'mini_backtrace',     '0.1.3'
  gem 'guard-minitest',     '2.3.1'
end

group :production do
  gem 'pg',             '0.17.1'
  gem 'rails_12factor', '0.0.2'
end
