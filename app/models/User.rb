class User < ActiveRecord::Base

  #has many books through collections 
  has_many :book_users
  has_many :books, through: :book_users
  has_many :authors, through: :books
  has_many :genres, through: :books

	# def all_book_users
	# 	# Return an array of all book_user instances associated with self.
	# 	Book_user.all.select{|instance| instance.user_id == self.id}
	# end

	# def all_book_ids
	# 	# Return an array of all book.id's associated with self.
	# 	self.all_book_users.map{|instance| instance.book_id}
	# end

	# def books
	# 	# DEPENDENT ON ALL_BOOK_USERS && ALL_BOOK_IDS
	# 	#returns array containing all books in that user's collection
	# 	self.all_book_ids.map do |book_id|
	# 		Book.all.find_by(id: book_id)
	# 	end.map{|book| book.title}
	# end


	# def add_to_collection?
	def read_book(book, username)
		# read_book(book) # takes instance of book
		# Takes a book "title" and an "author", finds/creates the associated book and adds it to the user's books array.
		# author = Author.find_or_create_by(name: author)
		# book = Book.find_or_create_by(title: title)
		# book.author = author
		# genre = Genre.find_or_create_by(name: genre)
		# book.genre = genre
		# book.save
		# book = book.id
		BookUser.find_or_create_by(user_id: username.id, book_id: book.id)
	end
end
