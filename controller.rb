require 'rubygems'
require 'sinatra'
require 'data_mapper'

require File.expand_path("../settings" , __FILE__)

###
# Routes
###
get '/' do
	hello = Hello.get(1)
	erb :index, :locals => { :hello => hello }
end