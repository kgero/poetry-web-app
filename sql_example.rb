require 'sequel'

# DB = Sequel.sqlite # memory database, requires sqlite3
DB = Sequel.connect('sqlite://testpoems.db')

# DB.create_table :poems do
#   primary_key :id
#   String :title
#   String :poet
#   String :url
# end

poems = DB[:poems] # Create a dataset

# Populate the table
poems.insert(:title => 'A Glimpse', :poet => 'Walt Whitman')
poems.insert(:title => 'America', :poet => 'Walt Whitman')
poems.insert(:title => 'Beat Beat Drums', :poet => 'Walt Whitman')
poems.insert(:title => 'After Apple Picking', :poet => 'Robert Frost')
poems.insert(:title => 'Out Out', :poet => 'Robert Frost')
poems.insert(:title => 'The Gift Outright', :poet => 'Robert Frost')
poems.insert(:title => 'Vita Nova', :poet => 'Louise Gluck')
poems.insert(:title => 'Mother and Child', :poet => 'Louise Gluck')
poems.insert(:title => 'Parable of the Swans', :poet => 'Louise Gluck')


# Print out the number of records
puts "Poem count: #{poems.count}"

# Print out the average price
puts "Frost poems: #{poems.where(:poet => 'Robert Frost').count}"