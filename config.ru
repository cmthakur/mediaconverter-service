require 'rubygems'
require 'bundler'
require 'sinatra'

Bundler.setup

require './media_converter_service'

run MediaConverterService