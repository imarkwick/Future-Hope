def table_guestlist(table)
	all_table_names = []
	table.each { |table| all_table_names << table.guestlist }
	all_table_names
end

def images_per_item(items)
	item_total = {}
	items.each { |item| item_total[item.title] = (item.names).split(",").length }
	item_total
end

def total_images(items_and_totals)
	items_and_totals.map { |item, total| (item + ', ') * total }
end
