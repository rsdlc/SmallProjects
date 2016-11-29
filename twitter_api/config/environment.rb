# Hace require de los gems necesarios.
# Revisa: http://gembundler.com/bundler_setup.html
#      http://stackoverflow.com/questions/7243486/why-do-you-need-require-bundler-setup
ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../../Gemfile', __FILE__)

require 'bundler/setup' if File.exists?(ENV['BUNDLE_GEMFILE'])

# Require gems we care about
require 'rubygems'

require 'uri'
require 'pathname'

require 'pg'
require 'active_record'
require 'logger'
require 'yaml'

require 'sinatra'
require "sinatra/reloader" if development?

require 'erb'
require 'twitter'
require 'oauth'
require 'sidekiq'
require 'redis'

# CLIENT = Twitter::REST::Client.new do |config|
#   config.consumer_key        = "oR4CtywxBNPA35JUYB5Vzte08"
#   config.consumer_secret     = "CWOU25qJKX6rYHCtL7XFNLLVZJmW2Zk9DCSO7Cpn60yitFgvQ7"
#   config.access_token        = "1732880545-MY4M8Fy3CH6vRwVmqoYw1tyw6CVuBioaPR4o7R9"
#   config.access_token_secret = "hAdxfi6FxdbEDGtRPASptVlkOnmXhyVLP0ew3q8TtGqkt"
# end


APP_ROOT = Pathname.new(File.expand_path('../../', __FILE__))

APP_NAME = APP_ROOT.basename.to_s


env_config = YAML.load_file(APP_ROOT.join('config', 'twitter.yaml'))

env_config.each do |key, value|
  ENV[key] = value      
end
# Configura los controllers y los helpers
Dir[APP_ROOT.join('app', 'controllers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'helpers', '*.rb')].each { |file| require file }
Dir[APP_ROOT.join('app', 'uploaders', '*.rb')].each { |file| require file }

# Configura la base de datos y modelos 
require APP_ROOT.join('config', 'database')
