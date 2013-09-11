require 'sinatra'
require 'json'

get '/customer/:name' do |name|
	j = build_json
	j["name"] = name
	add_link( j, "self", "http://localhost:4567/customer/#{name}")
	add_link( j, "address", "http://localhost:4567/customer/#{name}/address")
	j.to_json   
end

get '/customer/:name/address' do |name|
	j = build_json
	j["postcode"] = "NE13 6EY"
	add_link( j, "self", "http://localhost:4567/customer/#{name}/address")
	j.to_json   
end


def build_json
	j = Hash.new
	j["links"] = []
	j
end


def add_link( json, rel, url ) 
	j = {}
	j["rel"] = rel
	j["url"] = url
	json["links"] << j
end