require 'sinatra'
require 'sequel'
require 'pg'
require 'erb'

DB = Sequel.connect(ENV['DATABASE_URL'] || "postgres://qvigtqbjcjujkq:2aTeOgnlW1NuhT3SGAEcPpNzh6@ec2-54-243-30-73.compute-1.amazonaws.com:5432/d14pjbfuk22qfv")
# DB = Sequel.connect('sqlite://poemdb2.db')
poems = DB[:poetry]
# poem_distances = DB[:poem_distances]

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
	@poems = poems
	@poem = poems.where(:id => params['id']).first

	# entry = poem_distances.where(:poem1=>params['id']).or(:poem2=>params['id']).order(:distance).first
	@rec_poem = poems.where(:id => @poem[:close_poem]).first

	@poem_content = @poem[:poem].gsub(/\n/, '<br>')
	@rec_content = @rec_poem[:poem].gsub(/\n/, '<br>')

	# @relations = poem_distances.where(:poem1=>params['id']).or(:poem2=>params['id']).order(:distance).limit(10)
	erb :poem
end

post '/submit' do
	query = params[:query]
	@poems = poems.full_text_search([:title, :poet], query)
	@foo = "Results:"
	if @poems.count == 0
		@foo = "None found. Only exact matches are supported at this time. Try Charles Simic."
	end
	erb :index
end