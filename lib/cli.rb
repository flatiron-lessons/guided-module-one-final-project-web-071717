require_relative '../app/models/author.rb'
require_relative '../app/models/Book.rb'
require_relative '../app/models/book_user.rb'
require_relative '../app/models/genre.rb'
require_relative '../app/models/user.rb'

# Greeting & Initial Commands
def greet
  puts "Welcome to Books with Friends.\nPlease enter your username: Ex. brossbach\n\n"
end

def get_user_input
	gets.chomp
end

def find_user
	user_input = get_user_input
	User.all.find_or_create_by(name: user_input)
end

def initial_cmds
	puts "Here is a list of valid commands:\n\t - username.read_book 'Title' 'Author' 'Genre'\n\t - recommendations"
end

def read_or_recommend
	user_input = get_user_input
	if user_input == "recommendations"
		# random 20 books from googlebooks API
	elsif user_input == ""
		user_input = user_input.split(" '")

		title = user_input[1].chomp("'")
		author = user_input[2].chomp("'")
		genre = user_input[3].chomp("'")

		user.read_book(title: title, author: author, genre: genre)
	end
end

# greet
# user = find_user
# binding.pry
# initial_cmds
# read_or_recommend





















# def author_cmds
# 	puts "Enter an author from the list to get more information about that author."
# 	get_user_input
# end

# def book_cmds
# 	puts "Enter a book from the list to get more information about that book."
# 	get_user_input
# end

# def genre_cmds	
# 	puts "Enter an genre from the list to get more information about that genre."
# 	get_user_input
# end

# def select_list
# 	input = get_user_input

# 	if input == "list all authors"
# 		Author.all.each{|author| puts " - #{author.name}"}
# 		author_cmds

# 	elsif input == "list all books"
# 		Book.all.each{|book| puts " - #{book.name}"}
# 		book_cmds

# 	elsif input == "list all genres"
# 		Genre.all.each{|genre| puts " - #{genre.name}"}
# 		genre_cmds

# 	else
# 		puts "Please enter a valid command:"
# 		initial_cmds
# 	end
# end


# def more_info	
# 	input = get_user_input

# end