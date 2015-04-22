require 'spec_helper'

feature 'Izzy and Clare input names for tables' do

	scenario 'pre the event' do
		expect(Table.count).to eq(0)
		visit '/admin'
		add_table('1', 'Chris')
		expect(Table.count).to eq(1)
		table = Table.first
		expect(table.tablenumber).to eq('1')
		expect(table.guestlist).to eq('Chris')
	end	
	
	def add_table(tablenumber, guestlist)
		within('#new_table') do
			fill_in 'table-number', with: tablenumber
			fill_in 'guestlist', with: guestlist
			click_button 'Submit'
		end
	end
end