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
	end

	def greeting
	  puts "Welcome to Books with Friends.\nPlease enter your username.\nIf you don't have already have a username it will be created for you.\n Ex. brossbach\n\n"
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
		print "\nPlease enter a valid command:\n Ex. 1\n\n1 - List books\n2 - List authors\n3 - Recommend books\n4 - View my books\n5 - List other users\n6 - Exit\n"
		initial_response
	end

	def initial_response

		input = get_user_input
		case input

		when "1"
			list_books
		when "2"
			list_authors
		when "3"
			random_list_of_books
		when "4"
			if my_collection.length == 0
				puts "Sorry, you have no books in your collection. You can add a book by selecting 'Add a book to my list of books'."
			else
				puts my_collection
			end
		when "5"
			puts ""
			puts list_all_users
		when "6"
			puts "\nIt's alright, we knew you didn't read books anyway...\n Bye Felicia."

			exit!
		else
			initial_cmds
		end
		secondary_cmds
	end

	def secondary_cmds
		print "\nWhat would you like to do?\n\n1 - Add a book to my list\n2 - List books for author\n3 - View my books\n4 - Get description of a book\n5 - Delete book from my list\n6 - View books for another user\n7 - Go back\n8 - Exit\n\nPlease enter the corresponding number for the command you'd like.\n"
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
			input = get_user_input
			book = Book.all[(input.to_i)-1]
			username.read_book(book, username)
			puts "\n#{book.title} added to your list of books!\n\nYour list will update when you exit this session."	
		when "2" # list books for specified author
			list_authors
			puts "\nPlease enter the corresponding number for the author."
			input = get_user_input
			author = Author.all[input.to_i-1]
			author.books.map{|book| puts "\n1. #{book.title}"}
		when "3" # view my books
			if my_collection.length == 0
				puts "Sorry, you have no books in your collection. You can add a book by selecting 'Add a book to my list of books'."
			else
				puts my_collection
			end
		when "4" # view book description
			list_books
			puts "\nPlease enter the corresponding number for the book you'd like."
			input = get_user_input
			book = Book.all[(input.to_i)-1]
			puts "\n- #{book.title} Description - \n\n#{book.description}"
		when "5" # delete book from username.books
			delete_book
		when "6" # View books for another user
			puts "\nPick a user"
			puts list_all_users
			user_books = get_user_collection
			if user_books.length == 0
				puts "\nSorry, that user has no books in their collection."
			else
				puts ""
				puts user_books
			end
		when "7" # Go back
			initial_cmds
		when "8" # Exit
			puts "Thank you for using Books with Friends, #{username.name}!"
			exit!
		else
			puts "Please enter a valid command."
		end
		secondary_cmds
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
		puts "\n - Recommendations - "
		book = Book.all.sample(3)
		book.each_with_index{|book, index| puts "#{index +1}. #{book.title}\n  #{book.description}\n"}
	end

	def get_user_collection
		selected_user = get_user_input
		user = User.all.find_by(name: selected_user)
		user.books.map{|book| book.title}
	end

	def delete_book
		if username.books.length == 0
			puts "Sorry #{username.name}, but there are currently no books in your collection."
		else
			puts "\nEnter the title of the book you wish to delete."
			username.books.each{|book| puts "#{book.title}"}
			book_title = get_book_title
			book = Book.all.find_by(title: book_title)
			BookUser.delete(BookUser.find_by(book_id: book.id, user_id: username.id))
			puts "\n#{book.title} deleted from your collection!"
		end
	end

	def get_book_title
		book_title = get_user_input
		book_title = book_title.split(" ")
		book_title.each{|word| word.capitalize!}
		book_title = book_title.join(" ")
	end

	def my_collection
		puts ""
		username.books.map{|book| book.title}
	end

	def list_all_users
		User.all.map{|user| user.name}
	end
end