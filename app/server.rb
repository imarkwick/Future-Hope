require 'sinatra'
require 'data_mapper'

require_relative './lib/item'
require_relative './lib/guest'
require_relative 'data_mapper_setup'

set :partial_template_engine, :erb
set :public_dir, Proc.new { File.join(root, "..", "public") }

get '/' do 
	erb :index
end

get '/volunteer' do

	erb :volunteer
end

get '/display' do
	@items = Item.all
	erb :display
end

post '/display' do
	title = params['title']
	total = params['total']
	guests = params['guests'].split(' ').map do |guest|
		Guest.first_or_create(name: guest)
	end
	Item.create(title: title, total: total, guests: guests)
	puts guests
	redirect to('/volunteer')
end