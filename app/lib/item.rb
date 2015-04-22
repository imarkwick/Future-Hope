class Item

	include DataMapper::Resource

	property :id, 		Serial
	property :total,	String
	property :title,	String

end