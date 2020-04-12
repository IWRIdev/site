source 'https://rubygems.org'

gem 'rake'
gem 'hanami',       '~> 1.3'
gem 'sequel'
gem 'pg'

gem 'haml'

gem 'redcarpet'

gem 'monkey-hash'
gem 'cfgstore'
gem 'cfgdatabase'

group :development do
  # Code reloading
  # See: https://guides.hanamirb.org/projects/code-reloading
  gem 'shotgun', platforms: :ruby
  gem 'hanami-webconsole'
end

group :test, :development do
  gem 'dotenv', '~> 2.4'
  gem 'irb'
  gem 'pry-byebug'
end

group :test do
  gem 'rspec'
  gem 'capybara'
end

group :production do
  # gem 'puma'
end
