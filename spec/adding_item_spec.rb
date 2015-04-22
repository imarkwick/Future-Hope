require 'spec_helper'

feature 'Volunteer adds guest names to an item' do 

	scenario 'from the display page' do
		expect(Item.count).to eq(0)
		visit '/volunteer'
		add_item('5', 'Sponsor A Child');
		expect(Item.count).to eq (1)
		item = Item.first
		expect(Item.total).to eq('5')
		expect(Item.title).to eq('Sponsor A Child')
	end	

	def add_item(total, title)
		within('#new-item') do
			fill_in 'total',with: total
			select 'Sponsor A Child', :from => "auctionItem"
			click_button 'Submit'
		end
	end	
end