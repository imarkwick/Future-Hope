require 'sinatra'
require 'data_mapper'

require_relative './lib/item'
require_relative './lib/table'
require_relative 'data_mapper_setup'

set :partial_template_engine, :erb
set :public_dir, Proc.new { File.join(root, "..", "public") }

get '/' do 
	erb :index
end

get '/admin' do
	erb :admin
end

get '/volunteer' do
	erb :volunteer
end

get '/display' do
	@items = Item.all
	erb :display
end

post '/volunteer' do
	number = params['table-number']
	guests = params['guestlist']
	Table.create(tablenumber: number, guestlist: guests)
	redirect to('/admin')
end

post '/display' do
	title = params['title']
	total = params['total']
	names = params['names']
	Item.create(title: title, total: total, names: names)
	redirect to('/volunteer')
end