class BookUser < ActiveRecord::Base
		belongs_to :user
		belongs_to :book

#knows its users and the books in the collection
#belongs to a user and has many books

	def average_rating
	  #returns the average rating of all books in the collection
	end

	def highest_rating
	  #returns the highest rating in the collection
	end

	def size
	  #returns the number of books in the collection
	end

	def lowest_rating
	  #returns the lowest rating in the collection
	end

	def authors
	  #returns authors in collection
	end

	def books
	  #returns books in collection
	end

	def most_recent_book
	  #returns the newest item in the collection
	end

	def genres
	  #returns the genres in the collection
	end
end
