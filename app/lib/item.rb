class Item

	include DataMapper::Resource

	property :id, 		Serial
	property :total,	String
	property :title,	String

	has n, :guests, through: Resource

end