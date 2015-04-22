class Guest

	include DataMapper::Resource

	has n, :items, through: Resource

	property :id, 		Serial
	property :name, 	String

end