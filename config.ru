require 'rubygems'
require 'bundler'
require 'sinatra'

Bundler.setup

require './application'

run Sinatra::Application