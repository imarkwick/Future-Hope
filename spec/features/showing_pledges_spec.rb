feature 'Attending want to see who bought what' do 

	before(:each) do
		Item.create(names: 'izzy', total: '5')
	end

	scenario 'when displaying the mosaic' do
		visit '/display'
		expect(page).to have_content('izzy')
	end
	
end