# Configure your routes here
# See: https://guides.hanamirb.org/routing/overview
#
# Example:
# get '/hello', to: ->(env) { [200, {}, ['Hello from Hanami!']] }
get '/session/start', to: 'session#start'
get '/session/start', to: 'session#start'
get '/board', to: 'board#index'
get '/board', to: 'board#index'
