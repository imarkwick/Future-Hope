def table_guestlist(table)
	all_table_names = []
	table.each do |table| 
		if table.guestlist
			all_table_names << table.guestlist 
		end
	end
	all_table_names
end

def images_per_item(items)
	item_total = {}
	items.each do |item|
		if item.names 
			item_total[item.title] = (item.names).split(",").length
		end
	end
	item_total
end

def total_images(items_and_totals)
	items_and_totals.map { |item, total| (item + ', ') * total }
end
