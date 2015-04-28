require 'rubygems'
require_relative './app/server.rb'
Faye::WebSocket.load_adapter('thin')
run Sinatra::Application