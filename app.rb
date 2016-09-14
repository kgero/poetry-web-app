require 'sinatra'
require 'sequel'
require 'erb'

DB = Sequel.connect('sqlite://testpoems.db')
poems = DB[:poems]

get '/' do
	@foo = "Hello, World!"
	@poems = poems
	erb :index
end

get '/poem/:id' do
	@poem = poems.where(:id => params['id']).first
	erb :poem
end

post '/submit' do
	query = params[:query]
	@poems = poems.where(:poet => query)
	@foo = "results..."
	@helper = ""
	if @poems.count == 0
		@helper = "None found. Try Robert Frost."
	end
	erb :index
end