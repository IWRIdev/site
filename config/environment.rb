require 'bundler/setup'
require 'hanami/setup'
require_relative '../lib/iwrinet'
require_relative '../apps/iwrinet/application'
require_relative '../apps/adminka/application'

Hanami.configure do
  mount Adminka::Application, at: '/a'
  mount Iwrinet::Application, at: '/'

  mailer do
    root 'lib/iwrinet/mailers'

    # See https://guides.hanamirb.org/mailers/delivery
    delivery :test
  end

  environment :development do
    # See: https://guides.hanamirb.org/projects/logging
    logger level: :debug
  end

  environment :production do
    logger level: :info, formatter: :json, filter: []

    mailer do
      delivery :smtp, address: ENV.fetch('SMTP_HOST'), port: ENV.fetch('SMTP_PORT')
    end
  end
end
