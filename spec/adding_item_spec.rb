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

	scenario 'with some guest names' do
		visit '/volunteer'
		add_item('Sponsor A Child', '5', %w(Peter, Izzy));
		item = Item.first
		guest = Guest.first
		expect(guest.name).to include('Peter')
		expect(guest.name).to include('Izzy')
	end

	def add_item(title, total, guests = [])
		within('#new-item') do
			select 'Sponsor A Child', :from => "title"
			select 'Peter', :from => "guests"
			select 'Izzy', :from => "guests"
			fill_in 'total', with: total
			# guests.join(' ')
			click_button 'Submit'
		end
	end	
end