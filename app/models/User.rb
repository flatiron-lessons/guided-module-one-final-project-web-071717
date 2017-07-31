class User < ActiveRecord::Base

  #has many books through collections 

def collection
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

def add_book
  #takes in collection(self), title, and author and creates a new instance of book (Book.new)
end


end
