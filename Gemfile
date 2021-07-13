source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'active_model_serializers', '~> 0.10.0'
gem 'bootsnap', '>= 1.4.4', require: false
gem 'dotenv-rails', '~> 2.7.6'
gem 'interactor', '~> 3.0'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors', '~> 1.1.1'
gem 'rails', '~> 6.1.3', '>= 6.1.3.2'
gem 'redis', '~> 4.0'
gem 'redis-rails', '~> 5.0.2'
gem 'rest-client', '~> 2.1.0'
gem 'sidekiq', '~> 6.2.1'
gem 'whenever', '~> 1.0.0'

group :development, :test do
  gem 'pry'
  gem 'pry-byebug'
  gem 'pry-highlight'
  gem 'pry-rails'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'rubocop'
  gem 'spring'
end

group :test do
  gem 'factory_bot_rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'vcr'
  gem 'webmock'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
