get '/admin' do
	erb :admin
end

post '/admin' do
	number = params['table-number']
	guests = params['guestlist'].split(', ')
	guests.each { |guest| Table.first_or_create(tablenumber: number, guestlist: guest) }
	redirect to('/admin')
end