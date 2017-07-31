class User < ActiveRecord::Base

  #has many books through collections 
  has_many :book_users
  has_many :books, through: :book_users
  has_many :authors, through: :books

	def all_book_users
		# Return an array of all book_user instances associated with self.
		Book_user.all.select{|book_user| Book_user.user_id == self.id}
	end

	def all_book_ids
		# Return an array of all book.id's associated with self.
		self.all_book_users.select{|book_user| book_user.book_id}
	end

	def books
		# DEPENDENT ON ALL_BOOK_USERS && ALL_BOOK_IDS
		#returns array containing all books in that user's collection
		
	end

	def find_book
	  #takes in a title and author and finds the book
	end

	def recommended
	  #returns the top 3 books from user's collection based on rating
	end

	def rate_book
	  #takes in title and author and updates the rating
	end

	def read_book(title)
		book = Book.all.find_or_create_by(title: title)
		book= book.id
		Book_user.find_or_create_by(user_id: self.id, book_id: book)
	  #takes in collection(self), title, and author and creates a new instance of book (Book.new)
	end
end
