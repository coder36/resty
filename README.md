RESTY
=====

Command line interface for traversing a JSON based HATEOAS web service.

Find out a little bit more about HATEOAS at http://en.wikipedia.org/wiki/HATEOAS


Example usage
-------------

	C:\src\ruby\resty>ruby resty.rb

	$ pwd
	/
	$ setroot http://localhost:4567/customer/mark
	Root set to: http://localhost:4567/customer/mark
	$ p
	{
	  "links": [
	    {
	      "rel": "self",
	      "url": "http://localhost:4567/customer/mark"
	    },
	    {
	      "rel": "address",
	      "url": "http://localhost:4567/customer/mark/address"
	    }
	  ],
	  "name": "mark"
	}
	$ ls
	self
	address
	$ cd address
	$ ls
	self
	$ pwd
	/address
	$ p
	{
	  "links": [
	    {
	      "rel": "self",
	      "url": "http://localhost:4567/customer/mark/address"
	    }
	  ],
	  "postcode": "NE13 6EY"
	}
	$ http://localhost:4567/customer/mark



Setup
-----

	gem install json
	gem install rest-client
	ruby testy.rb

Optionally start the test server

	ruby test_server.rb



