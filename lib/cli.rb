require_relative '../app/models/author.rb'
require_relative '../app/models/Book.rb'
require_relative '../app/models/book_user.rb'
require_relative '../app/models/genre.rb'
require_relative '../app/models/user.rb'

class CLI
	# Greeting & Initial Commands
	attr_reader :username
	def run
		greeting
		name = gets.chomp
		@username = User.all.find_or_create_by(name: name)
		initial_cmds
		# first_response = gets.chomp
		#initial_response
		secondary_cmds
		# second_response = gets.chomp
		#secondary_response
	end

	def greeting
	  puts "Welcome to Books with Friends.\nPlease enter your username: Ex. brossbach\n\n"
	end

	def get_user_input
		print "Please enter a command:  "
		gets.chomp
	end

	def find_user
		user_input = get_user_input
		User.all.find_or_create_by(name: user_input)
	end

	def initial_cmds
		puts "Here is a list of valid commands:\n" 
		puts " 1 - List Books"
		puts " 2 - List Authors" 
		puts " 3 - Recommend Books"
		puts " 4 - View My Collection"
		puts " 5 - List Other Users\n"
		puts "Please enter the corresponding number for the command you'd like"
		initial_response
	end

	def initial_response

		input = get_user_input

		if input == "1"
			book = Book.all.each_with_index{|book, index| puts "#{index+1}. #{book.title}"}
			secondary_cmds
		elsif input == "2"
			Author.all.each_with_index{|author, index| puts "#{index +1}. #{author.name}"}
		elsif input == "3"
			book = Book.all.sample(3)
			book.each_with_index{|book, index| puts "#{index +1}. #{book.title}"}
		elsif input == "4"
			if my_collection.length == 0
				puts "Sorry, you have no books in your collection. You can add a book by selecting 'Add a book to my list of books'."
				secondary_cmds
			else
				puts my_collection
				secondary_cmds
			end
		elsif input == "5"
			puts list_all_users
		else
			puts "Please enter a valid command."
			initial_cmds
		end
	end

	def secondary_cmds
		puts "\nWhat would you like to do?\n"
		puts " 1 - Add a book to my list"
		puts " 2 - View my books"
		puts " 3 - View Books for Another User"
		puts " 4 - Go back"
		puts " 5 - Exit\n"
		puts "Please enter the corresponding number for the command you'd like."
		secondary_response
	end

	def secondary_response

		input = get_user_input

		if input == "1" # Add book to my list
			book = Book.all.each_with_index{|book, index| puts "#{index+1}. #{book.title}, #{book.author.name}"}
			puts "Please enter the corresponding number for the book you'd like."
			input = get_user_input
			book = Book.all[input.to_i-1]
			username.read_book(book, username)
			puts "#{book.title} added to your list of books!"
			secondary_cmds
		elsif input == "2" # view my books
			puts my_collection
			secondary_cmds
		elsif input == "3" # View books for another user
			puts "Pick a user"
			puts list_all_users
			user_books = get_user_collection
			if user_books.length == 0
				puts "Sorry, that user has no books in their collection."
				secondary_cmds
			else
				puts user_books
				secondary_cmds
			end
		elsif input == "4" # Go back
			initial_cmds
		elsif input == "5" # Exit
			puts "Thank you for using Books with Friends."
			exit!
		else
			puts "Please enter a valid command."
			secondary_cmds
		end
	end

	def get_user_collection
		selected_user = get_user_input
		user = User.all.find_by(name: selected_user)
		user.books.map{|book| book.title}
	end

	def my_collection
		username.books.map{|book| book.title}
	end

	def list_all_users
		User.all.map{|user| user.name}
	end
end