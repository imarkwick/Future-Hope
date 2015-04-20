require 'spec_helper'

describe 'Item' do
	
	context 'Item is created in the database' do

		it 'should be created and retrieved from the database' do
			expect(Item.count).to eq(0)
			Item.create(total: '5')
			expect(Item.count).to eq(1)
			item = Item.first
			expect(item.total).to eq('5')
			item.destroy
			expect(Item.count).to eq(0)
		end
	end
end