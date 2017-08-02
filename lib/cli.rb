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
		confirm_login
		initial_cmds
		secondary_cmds
	end

	def greeting
	  puts "Welcome to Books with Friends.\nPlease enter your username.\nIf you don't have already have a username it will be created for you:\n Ex. brossbach\n\n"
	end

	def confirm_login
		puts "Login successful! What would you like to do?"
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
		print "\nPlease enter a valid command:\n Ex. 1\n\n1 - List Books\n2 - List Authors\n3 - Recommend Books\n4 - View My Collection\n5 - List Other Users\n6 - Exit\n"
		initial_response
	end

	def initial_response

		input = get_user_input
		case input

		when "1"
			list_books
			secondary_cmds
		when "2"
			list_authors
			secondary_cmds
		when "3"
			random_list_of_books
			secondary_cmds
		when "4"
			if my_collection.length == 0
				puts "Sorry, you have no books in your collection. You can add a book by selecting 'Add a book to my list of books'."
				secondary_cmds
			else
				puts my_collection
				secondary_cmds
			end
		when "5"
			puts list_all_users
		when "6"
			puts "\nIt's alright, we knew you didn't read books anyway...\n Bye Felicia."

			exit!
		else
			initial_cmds
		end
	end

	def secondary_cmds
		print "\nWhat would you like to do?\n\n1 - Add a book to my list\n2 - List books for author\n3 - View my books\n4 - Delete Book From my List\n5 - View Books for Another User\n6 - Go back\n7 - Exit\n\nPlease enter the corresponding number for the command you'd like."
		secondary_response
	end

	def user_input
		input = gets.chomp
	end

	def secondary_response

		input = get_user_input
		case input

		when "1" # Add book to my list
			list_books
			puts "\nPlease enter the corresponding number for the book you'd like."
			user_input
			book = Book.all[input.to_i-1]
			username.read_book(book, username)
			puts "\n#{book.title} added to your list of books!\n\nYour list will update when you exit this session."
			secondary_cmds
		when "2" # list books for specified author
			list_authors
			puts "\nPlease enter the corresponding number for the author."
			user_input
			author = Author.all[input.to_i-1]
			author.books.map{|book| puts "\n1. #{book.title}"}
			secondary_cmds
		when "3" # view my books
			puts my_collection
			secondary_cmds
		when "4" # delete book from username.books
			delete_book
			secondary_cmds
		when "5" # View books for another user
			puts "\nPick a user"
			puts list_all_users
			user_books = get_user_collection
			if user_books.length == 0
				puts "\nSorry, that user has no books in their collection."
				secondary_cmds
			else
				puts user_books
				secondary_cmds
			end
		when "6" # Go back
			initial_cmds
		when "7" # Exit
			puts "Thank you for using Books with Friends."
			exit!
		else
			puts "Please enter a valid command."
			secondary_cmds
		end
	end

	def list_books
		puts "\n-Books-"
		Book.all.each_with_index{|book, index| puts "#{index+1}. #{book.title}"}
	end

	def list_authors
		puts "\n -Authors-"
		Author.all.each_with_index{|author, index| puts "#{index +1}. #{author.name}"}
	end

	def list_books_with_authors
		puts "\n-Books-"
		Book.all.each_with_index{|book, index| puts "#{index+1}. #{book.title}, #{book.author.name}"}
	end

	def random_list_of_books
		puts "\n-Recommendations-"
		book = Book.all.sample(3)
		book.each_with_index{|book, index| puts "#{index +1}. #{book.title}"}
	end

	def get_user_collection
		selected_user = get_user_input
		user = User.all.find_by(name: selected_user)
		user.books.map{|book| book.title}
	end

	def delete_book
		puts "\nEnter the title of the book you wish to delete."
		username.books.each{|book| puts "#{book.title}"}
		book_title = get_user_input
		book_title = book_title.split(" ")
		book_title.each{|word| word.capitalize!}
		book_title = book_title.join(" ")
		book = Book.all.find_by(title: book_title)
		BookUser.delete(BookUser.find_by(book_id: book.id, user_id: username.id))
		puts "#{book} deleted from your collection!"
	end

	def my_collection
		puts ""
		username.books.map{|book| book.title}
	end

	def list_all_users
		User.all.map{|user| user.name}
	end
end