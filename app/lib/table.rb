class Table

	include DataMapper::Resource

	property :id, 					Serial
	property :tablenumber,	String
	property :guestlist,		String

end