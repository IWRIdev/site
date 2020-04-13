require 'app-config'
require 'app-logger'
require 'app-database'

App::Config.init approot: Pathname( __dir__ ).parent.parent, configdir: 'config/settings'
App::Logger.new
App::Database.instance if defined?( Cfg.db )
