
require 'rest_client'
require 'json'

class Resty

	def initialize
		@com = Commands.new
	end

	def start
		begin 
			print "$ "
			s = gets.chomp
			action( s.chomp.split ) unless s.empty?			
		end while true 
	end

	def action( args )
		command = args[0]
		args.shift
		if @com.respond_to? command
			@com.send(command,args) 
		else
			puts "\'#{command}\' is not a recognised command"
		end
	end

end


class Commands

	def initialize
		@json = []
		@pwd = []
		@urls = []
	end

	def exit(args)
		exit! 0
	end

	def pwd(args)
		s = @pwd.inject("") { |res,n| res + "/" + n }
		if @urls.empty?
			puts "/"
		else
			puts "#{@urls.first} :: #{s}" 
		end
	end

	def cd(args)
		rel = args[0]		
		case rel
		when '..'
			@json.pop unless @json.empty?
			@pwd.pop unless @json.empty?
			@urls.pop unless @json.empty?
		else
			if get_rels.include?rel

				url = get_url(rel)
				j = load_url(url)
				unless j.nil?
					@pwd << rel
					@json << j
					@urls << url
				end
			else
				puts "'#{rel}' does not exist"
			end
		end
	end

	def root(args)
		puts @urls.first
	end

	def setroot(args)
		url = args[0]
		j = load_url(url)

		unless j.nil?
			@json.clear
			@urls.clear
			@json << j		
			@urls << url
			puts "Root set to: #{url}"
		end
	end

	def p(args)
		puts JSON.pretty_generate(@json.last)
	end

	def url(args)
		puts @urls.last
	end

	def ls(args)
		puts get_rels
	end

	private 

	def load_url(url)
		begin
			JSON.parse( RestClient.get(url).body )	
		rescue
			puts "Error: could not load #{url}"
			nil
		end
	end	

	def get_url(rel)
		url = ""
		@json.last["links"].each do |n|
			url = n["uri"] if n["rel"] == rel
		end
		url
	end

	def get_rels
		begin
			@json.last["links"].map { |n| n["rel"] }
		rescue
			[]
		end
	end

end

t = Resty.new
t.start()