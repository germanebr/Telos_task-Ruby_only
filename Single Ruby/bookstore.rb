require_relative "modules.rb"
require_relative "classes.rb"

include Tools

bookstore = Tools.create_store()

client1 = Tools.create_client(bookstore)

seller1 = Tools.create_seller(bookstore)
seller2 = Tools.create_seller(bookstore)

boook1 = Tools.create_book(bookstore,seller1)
boook2 = Tools.create_book(bookstore,seller1)
boook3 = Tools.create_book(bookstore,seller2)

Tools.browse_books(bookstore)
buy_book = Tools.get_book(bookstore)
client1.add_book(buy_book)
client1.buy_books(bookstore)

Tools.review_store(bookstore)
