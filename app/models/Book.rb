class Book < ActiveRecord::Base

  belongs_to :author
  has_many :book_users
  has_many :users, through: :book_users

  def genre
    Genre.all.find{|genre| self.genre_id == genre.id}.name
  end

  def author
    Author.all.find{|author| self.author_id == author.id}.name
  end

  def users
    all_books = Book_user.all.select{|book| book.id == self.id}
    binding.pry
  end
end
