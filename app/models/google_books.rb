module GoogleBooks
	class Adapter
		attr_reader :term

		BASE_URL = "https://www.googleapis.com/books/v1/volumes"

		def initialize(term = 'ruby programming')
			@term = term
		end

		def create_books_and_authors
			response = RestClient.get("#{BASE_URL}?q=#{self.term}")
			data = JSON.parse(response.body)
			Book.new(title: book['volumeInfo']['title'], )
			if data['items'].first['volumeinfo']['authors']
				author_name = data['items'].first['volumeinfo']['authors'].first
				author = Author.find_or_create_by(name: author_name)
			end

			book.author = author
			book.save
		end
	end
end