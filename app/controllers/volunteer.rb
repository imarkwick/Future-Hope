get '/volunteer' do
	@number = session[:mytable]
	@tables = Table.all
	if @number 
		@table = Table.all(:tablenumber => @number)
		if @table.first(:tablenumber => @number).guestlist
			@all_table_names = table_guestlist(@table)
		end
	end
	erb :volunteer
end

post '/volunteer' do
	session[:mytable] = params['tablenumber']
	redirect '/volunteer'
end