module Tools
  #Create a store
  def create_store()
    puts "Creating a new book store..."
    store = Store.new()
    return store
  end

  #Reviews the general info of the store
  def review_store(store)
    puts "Showing sellers..."
    for seller in store.sellers
      puts "#{seller.name}. Earnings = $#{seller.earnings.to_s}"
    end
    puts "\nShowing clients..."
    for client in store.clients
      puts "#{client.name}. Funds = $#{client.funds.to_s}"
    end
    puts "\nShowing books"
    for book in store.books
      puts "#{book.title} selled by #{book.seller}. Sold: #{book.sold.to_s}"
    end
    puts "\nTotal income = $#{store.revenue.to_s}"
  end

  #Create a seller
  def create_seller(store)
    puts "Insert your name:"
    name = gets.chomp()
    puts "Insert your phone number:"
    phone = gets.chomp()
    puts "Insert your email address:"
    email = gets.chomp()
    puts "Please insert a password:"
    password = gets.chomp()

    seller = Seller.new(name,phone,email,password)
    store.store_seller(seller)
    return seller
  end

  #Create a client
  def create_client(store)
    puts "Insert your name:"
    name = gets.chomp()
    puts "Insert your physicall address:"
    address = gets.chomp()
    puts "Insert your email address:"
    email = gets.chomp()
    puts "Please insert a password:"
    password = gets.chomp()

    client = Client.new(name,email,address,password)
    store.add_client(client)
    return client
  end

  #Create a book
  def create_book(store,seller)
    puts "Please write the book\'s title:"
    title = gets.chomp()
    puts "Please write the book\'s author:"
    author = gets.chomp()
    puts "Please write a brief description of the book:"
    desc = gets.chomp()
    puts "Please insert the book\'s price:"
    price = gets.chomp().to_f

    seller.add_book(store,title,author,desc,price)
  end

  #Log in a seller or customer
  def log_in(person)
    if person.login
      puts "You\'re already logged in\n"
    else
      puts "Please insert your password:"
      password = gets.chomp()
      if person.password == password
        person.login = true
      else
        person.login = false
        puts "Incorrect password... try again\n"
      end
    end
  end

  #Log out a seller or customer
  def log_out(person)
    if person.login
      person.login = false
    end
    puts "Logged out successfully\n"
  end
end
