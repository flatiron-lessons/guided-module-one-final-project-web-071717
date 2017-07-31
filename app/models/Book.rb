class Book < ActiveRecord::Base

  belongs_to :author
  belongs_to :genre
  has_many :book_users
  has_many :users, through: :book_users

  def self.find_author_for(title: nil)
    book = self.all.find_by(title: title)
    book.author.name
  end

end
