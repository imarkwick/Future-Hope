class Item

	include DataMapper::Resource

	property :id, 		Serial
	property :total,	String
	property :title,	String
	property :names,	String

end