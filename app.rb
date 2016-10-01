require 'sinatra'
require 'sequel'
require 'erb'

DB = Sequel.connect('sqlite://poemdb2.db')
poems = DB[:poetry]
poem_distances = DB[:poem_distances]

get '/' do
	rand_nums = 10.times.map{ Random.rand(poems.count) } 
	@foo = "Or select a poem from random. Refresh the page to get another random set of poems."
	@poems = poems.where(:id => rand_nums)
	erb :index
end

get '/howitworks' do
	erb :howitworks
end

get '/poem/:id' do
	@poem = poems.where(:id => params['id']).first
	@poems = poems
	@relations = poem_distances.where(:poem1=>params['id']).or(:poem2=>params['id']).order(:distance).limit(10)
	erb :poem
end

post '/submit' do
	query = params[:query]
	@poems = poems.where(:poet => query)
	@foo = "results..."
	if @poems.count == 0
		@foo = "None found. Try Robert Frost."
	end
	erb :index
end