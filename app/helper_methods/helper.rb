def table_guestlist(table)
	all_table_names = []
	table.each { |table| all_table_names << table.guestlist }
	all_table_names
end