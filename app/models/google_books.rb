module GoogleBooks
	class Adapter
		attr_reader :term

		BASE_URL = "https://www.googleapis.com/books/v1/volumes"

		# def initialize(term = "ruby programming")
		# 	@term = term
		# end

		def create_books_and_authors
			response = RestClient.get("https://www.googleapis.com/books/v1/volumes/?q=ruby+programming")
			# response = RestClient.get("#{BASE_URL}?q=#{self.term}")
			data = JSON.parse(response.body)
			book_array = data["items"]
			#database = 0
			#while database < 2
				book_array.each do |book_in_array|
					book = Book.new(title: book_in_array["volumeInfo"]["title"])
				#book = Book.new(title: data["items"][0]["volumeInfo"]["title"])
					if book_in_array["volumeInfo"]["authors"]
						author_name = book_in_array["volumeInfo"]["authors"].first
						author = Author.find_or_create_by(name: author_name)
					end
					if book_in_array["volumeInfo"]["categories"]	
						genre_name = book_in_array["volumeInfo"]["categories"].first
						genre = Genre.find_or_create_by(name: genre_name)
					end
					if book_in_array["volumeInfo"]["description"]
						description = book_in_array["volumeInfo"]["description"]
					end
					book.genre = genre
					book.author = author
					book.description = description
					book.save
				end
			#	database+=1
			#end

			# book.genre = genre
			# book.author = author
			# book.save
		end
	end
end