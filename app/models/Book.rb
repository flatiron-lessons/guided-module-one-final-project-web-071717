class Book < ActiveRecord::Base

  #belongs to a user through a collection
  #belongs to a collection
  #has an author, title, rating, genre, summary
  #maybe has a link to Google Books API -- "learn more"

  def collections
    #take an instance of the book(self) and returns the collections it appears in
  end

  def author/genre
    #see if ActiveRecord will return Book.author without writing the specific method
  end

  

end
