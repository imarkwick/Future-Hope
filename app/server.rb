require 'sinatra'
require 'data_mapper'

require_relative './lib/item'
require_relative './lib/table'
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
	guests = params['guestlist']
	Table.create(tablenumber: number, guestlist: guests)
	redirect to('/admin')
end

get '/volunteer-table' do
	erb :volunteertable
end

get '/volunteer' do
	@number = session[:mytable]
	@tables = Table.all
	if @number 
		@table = Table.first(:tablenumber => @number)
		if @table.guestlist
			@guestlist = (@table.guestlist).split(",")
		end
	end
	erb :volunteer
end

post '/volunteer' do
	session[:mytable] = params['tablenumber']
	redirect '/volunteer'
end

get '/display' do
	@items = Item.all
	@total = (@items[0].names).split(",").length
	@totalitems = @items * @total
	erb :display
end

post '/display' do
	title = params['title']
	total = params['total']
	names = params['names']
	Item.create(title: title, total: total, names: names)
	redirect to('/volunteer')
end

