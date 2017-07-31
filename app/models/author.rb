class Author < ActiveRecord::Base

	has_many :books # author.books
	has_many :book_users, through: :books # author.book_users
	has_many :users, through: :book_users # author.users

	def self.list_books_for(author: nil)
    author = self.all.find_by(name: author)
   	author.books.map{|book| book.title}
  end

  def self.list_genres_for(author: nil)
  	author = self.all.find_by(name: author)
  	author.books.map{|book| book.genre.name}
  end
end
