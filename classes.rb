=begin
  Coding designed by Germán Eduardo Baltazar Reyes

  This file includes the overall classes for generating the clients and sellers
  of the online book store.
=end

=begin
  Class for the book store

  Input:
    books => List of books in the store (Array[Book])
    sellers => List of sellers (Array[Seller])
    clients => List of clients (Array[Client])
    revenue => Total income of the store (Int)
=end
class Store
  attr_accessor :books, :sellers, :clients, :revenue

  #Create the book store
  def initialize()
    @books = Array.new
    @sellers = Array.new
    @clients = Array.new
    @revenue = 0
    puts "Store created!\n"
  end

  #Add a seller to the store
  def store_seller(seller)
    if @sellers.include? seller
      puts "Account already registered. Please log in\n"
    else
      position = @sellers.length()
      @sellers[position] = seller
      puts "#{seller.name} registered as seller...\n"
    end
  end

  #Add a client to the store
  def add_client(client)
    if @clients.include? client
      puts "Account already registered. Please log in\n"
    else
      position = @clients.length()
      @clients[position] = client
      puts "#{client.name} registered as client...\n"
    end
  end

  #Add a book to the store
  def add_book(book)
    position = @books.length()
    @books[position] = book
    puts "#{book.title} added...\n"
  end

  #Sell a book
  def sell_book(book)
    book.sold = true
    @revenue += 1
    give_income(book.seller, book.price)
    puts "#{book.title} of #{book.seller} is sold\n"
  end

  #Gives the income to the seller
  def give_income(name, price)
    for seller in @sellers
      if seller.name == name
        seller.add_income(price)
      end
    end
  end

  #Browse available books
  def browse_books(title)
    if title == ''
      show_all = true
    else
      show_all = false
    end

    for book in @books
      if !book.sold
        if show_all
          puts "\n#{book.title}, #{book.author}: $#{book.price}"
          puts "#{book.desc}"
          puts "Seller: #{book.seller}\n"
        elsif title == book.title
          puts "\n#{book.title}, #{book.author}: $#{book.price}"
          puts "#{book.desc}"
          puts "Seller: #{book.seller}\n"
        end
      end
    end
  end
end

=begin
  Class for the seller account

  Input:
    name => Name of the seller (String)
    phone => Phone number of the seller (String)
    email => Email of the seller (String)
    password => Password for log in (String)
    earnings => Total profit the seller has of the selled items (Float)
    login => Verifies if the user has logged in (Boolean)
=end
class Seller
  attr_accessor :name, :phone, :email, :password, :earnings, :login

  #Create the Seller account
  def initialize(name,phone,email,password)
    @name = name
    @phone = phone
    @email = email
    @password = password
    @earnings = 0
    @login = true
  end

  #Add a book to the book store
  def add_book(store,title,author,description,price)
    if @login
      new_book = Book.new(title,author,description,price, @name)
      store.add_book(new_book)
    else
      puts "Please login the seller first\n"
    end
  end

  #Visualize a list of all the sold books
  def sold_books(store)
    if @login
      books = store.books

      for book in books
        sold = book.is_sold

        if sold and book.seller == @name
          puts "Author: #{book.author}, Title: #{book.title}, Price: #{book.price}\n"
        end
      end
    else
      puts "Please login the seller first\n"
    end
  end

  #Outputs the total income of the seller
  def income()
    if @login
      puts "Your total income is of $#{@earnings}\n"
    else
      puts "Please login the seller first\n"
    end
  end

  #Adds the value of the buyed book to the total incomes
  def add_income(price)
    @earnings += price
  end
end

=begin
  Class for the client account

  Input:
    name => Name of the client (String)
    email => Email of the client (String)
    address => Address of the client (String)
    password => Password for log in (String)
    funds => How much the client can spend (Float)
    cart => Shopping cart of the client (Array[Book])
    login => Verifies if the user has logged in (Boolean)
=end
class Client
  attr_accessor :name, :email, :address, :password, :funds, :cart, :login

  #Create the Client account
  def initialize(name,email,address,password)
    @name = name
    @email = email
    @address = address
    @password = password
    @funds = 50
    @cart = Array.new
    @login = true
    puts "#Thanks for registering #{@name}!\nHere\'s $50 for you to start purchasing :D\n"
  end

  #Add a book to the shopping cart
  def add_book(book)
    if @login
      position = @cart.length()
      @cart[position] = book
      puts "#{book.title} added to the shopping cart...\n"
    else
      puts "Please login the client first\n"
    end
  end

  #Buy the books of the shopping cart
  def buy_books(store)
    total = 0
    if @login
      for book in @cart
        total += book.price
      end

      if funds >= total
        for book in @cart
          store.sell_book(book)
        end

        @funds -= total
        @cart = Array.new
        puts "You have $#{funds} left"
      else
        puts "Insufficient funds...\n"
      end
    else
      puts "Please login the client first\n"
    end
  end
end

=begin
  Class for books

  title => Title of the book (String)
  author => Author of the book (String)
  desc => Description of the book (String)
  price => Price of the book (Float)
  seller = Who is selling the book (String)
  sold = Determines if the book has been sold or not (Boolean)
=end
class Book
  attr_accessor :title, :author, :desc, :price, :seller, :sold

  def initialize(title,author,desc,price,seller)
    @title = title
    @author = author
    @desc = desc
    @price = price
    @seller = seller
    sold = false
  end
end
