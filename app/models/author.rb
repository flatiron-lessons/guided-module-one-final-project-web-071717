class Author < ActiveRecord::Base

	has_many :books # author.books
	has_many :book_users, through: :books # author.book_users
	has_many :users, through: :book_users # author.users

end
