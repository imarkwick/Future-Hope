require 'spec_helper'

feature 'Volunteer adds guest names to an item' do 

	scenario 'from the display page' do
		expect(Item.count).to eq(0)
		visit '/volunteer'
		add_item('child', '5', 'Peter');
		expect(Item.count).to eq (1)
		item = Item.first
		expect(item.title).to eq('child')
		expect(item.total).to eq('5')
	end	

	scenario 'with some guest names' do
		visit '/volunteer'
		add_item('child', '5', ["Peter", "Izzy"]);
		item = Item.first
		expect(item.names).to include('Peter')
		expect(item.names).to include('Izzy')
	end

	def add_item(title, total, names)
		within('#new-item') do
			select "child", :from => "title"
			select 'Peter', :from => "names[]"
			select 'Izzy', :from => "names[]"
			fill_in total, with: total
			click_button 'Submit'
		end
	end	
end