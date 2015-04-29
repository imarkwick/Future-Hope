get '/display' do
	@items = Item.all
	items_and_totals = images_per_item(@items)
	total_items = total_images(items_and_totals)
	list = total_items.join('')
	@array = list.split(',')
	@array.delete(@array.last)
	@array.each { |image| image[0] = '' if image[0] == ' ' }	
	erb :display
end

post '/display' do
	title = params['title']
	total = params['total']
	names = params['names']
	Item.create(title: title, total: total, names: names)
	redirect to('/volunteer')
end