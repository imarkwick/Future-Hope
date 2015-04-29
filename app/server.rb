require 'sinatra'
require 'data_mapper'
require 'faye/websocket'

Faye::WebSocket.load_adapter('thin')

require_relative './lib/item'
require_relative './lib/table'
require_relative './helper_methods/helper'
require_relative 'data_mapper_setup'

enable :sessions
set :session_secret, 'super secret'
set :partial_template_engine, :erb
set :public_dir, Proc.new { File.join(root, "..", "public") }

require_relative 'controllers/admin'
require_relative 'controllers/volunteer_table'
require_relative 'controllers/volunteer'
require_relative 'controllers/display'


