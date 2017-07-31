require_relative '../config/environment.rb'

lotr = Book.create(title: "Lord of the Rings")
hp = Book.create(title: "Harry Potter")
omam = Book.create(title: "Of Mice and Men")
tt = Book.create(title: "The Tempest")
rj = Book.create(title: "Romeo and Juliet")
md = Book.create(title: "Moby Dick")

fts = Genre.create(name: "Fantasy")
f = Genre.create(name: "Fiction")
nf = Genre.create(name: "Non-Fiction")
hf = Genre.create(name: "Historial Fiction")

tom = Author.create(name: "Tom")
beth = Author.create(name: "Beth")
tony = Author.create(name: "Tony")
andy = Author.create(name: "Andy")
kristie = Author.create(name: "Kristie")
jkr = Author.create(name: "JKR")

james = User.create(name: "James")
brigit = User.create(name: "Brigit")