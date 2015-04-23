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
	guests = params['guestlist'].split(',')
	guests.each { |guest| Table.first_or_create(tablenumber: number, guestlist: guest) }
	redirect to('/admin')
end

get '/volunteer/table' do
	erb :volunteertable
end

get '/volunteer' do
	@number = session[:mytable]
	@tables = Table.all
	@all_table_names = []
	if @number 
		@table = Table.all(:tablenumber => @number)
		if @table.first(:tablenumber => @number).guestlist
			@table.each { |table| @all_table_names << table.guestlist }
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

