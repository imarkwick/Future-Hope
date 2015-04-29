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

get '/' do 
	erb :index
end

get '/admin' do
	erb :admin
end

post '/admin' do
	number = params['table-number']
	guests = params['guestlist'].split(', ')
	guests.each { |guest| Table.first_or_create(tablenumber: number, guestlist: guest) }
	redirect to('/admin')
end

get '/volunteer-table' do
	erb :volunteertable
end

def getSocket
	@@ws ||= Faye::WebSocket.new(request.env, nil, ping: 5)
	@@ws
end

get '/volunteer' do
	@number = session[:mytable]
	@tables = Table.all
	if @number 
		@table = Table.all(:tablenumber => @number)
		if @table.first(:tablenumber => @number).guestlist
			@all_table_names = table_guestlist(@table)
		end
	end

	if (Faye::WebSocket.websocket?(env))

		puts "----"

		ws = getSocket

		ws.on(:open) do |event|
			ws.send "Hello Client!"
			puts 'Volunteer: On Open'
		end

		ws.on(:message) do |msg|
			puts "Volunteer on message."
			ws.send(msg.data)
		end

		ws.on(:close) do |event|
			puts 'On Close'
		end

		ws.rack_response
	else
		erb :volunteer
	end
end

post '/volunteer' do
	session[:mytable] = params['tablenumber']
	redirect '/volunteer'
end

get '/display' do

	@items = Item.all
	items_and_totals = images_per_item(@items)
	total_items = total_images(items_and_totals)
	list = total_items.join('')
	@array = list.split(',')
	@array.delete(@array.last)
	@array.each { |image| image[0] = '' if image[0] == ' ' }	

	if (Faye::WebSocket.websocket?(env))

		puts '******************'

		ws = getSocket

		ws.on(:open) do |event|
			puts 'DISPLAY: On Open'
		end

		ws.on(:message) do |msg|
			puts "DISPLAY received message"
			ws.send(msg.data)
			puts 'display message is...' + msg.data
		end

		ws.on(:close) do |event|
			puts 'On Close'
		end

		ws.rack_response
	else
		erb :display
	end
end

post '/display' do
	title = params['title']
	total = params['total']
	names = params['names']
	Item.create(title: title, total: total, names: names)
	redirect to('/volunteer')
end

