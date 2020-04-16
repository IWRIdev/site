source 'https://rubygems.org' do

  gem 'rake'
  gem 'hanami', '~> 1.3'
  gem 'sequel'
  gem 'pg'

  gem 'haml'
  gem "shrine", "~> 3.0"
  gem 'redcarpet'
  gem 'workflow'

  gem 'monkey-hash'
  gem 'cfgstore'
  gem 'cfgdatabase'
  gem 'sequel_workflow_persistence'

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
    gem 'thor'
  end

  group :test do
    gem 'rspec'
    gem 'capybara'
  end

  group :production do
    gem 'puma'
  end

end
