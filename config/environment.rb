require 'bundler'
Bundler.require

# require_relative "../app/models/author.rb"
# require_relative "../app/models/book.rb"
# require_relative "../app/models/book_user.rb"
# require_relative "../app/models/user.rb"
require_all "app"

ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: 'db/development.db')
require_all 'lib'