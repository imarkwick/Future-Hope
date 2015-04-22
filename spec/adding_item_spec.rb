require 'spec_helper'

feature 'Volunteer adds guest names to an item' do 

	scenario 'from the display page' do
		expect(Item.count).to eq(0)
		visit '/volunteer'
		add_item('Sponsor A Child', '5');
		expect(Item.count).to eq (1)
		item = Item.first
		expect(item.title).to eq('Sponsor A Child')
		expect(item.total).to eq('5')
	end	

	def add_item(title, total)
		within('#new-item') do
			select 'Sponsor A Child', :from => "title"
			fill_in 'total',with: total
			click_button 'Submit'
		end
	end	
end