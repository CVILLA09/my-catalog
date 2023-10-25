class BookManager
  def initialize
    @books = []
  end

  def list_books
    if @books.empty?
      puts 'There are no books yet!'
    else
      puts 'List of all books:'
      @books.each_with_index do |book, index|
        puts format_item(index, book, :author, :title, :publisher, :genre, :cover_state, :label)
      end
    end
  end

  def add_book
    puts 'Enter the details for the book:'
    print 'Author: '
    author = gets.chomp
    print 'Title: '
    title = gets.chomp
    print 'Publisher: '
    publisher = gets.chomp
    print 'Publish Date (YYYY/MM/DD): '
    publish_date = gets.chomp
    print 'Genre: '
    genre = gets.chomp
    print 'Cover State: '
    cover_state = gets.chomp
    print 'Label: '
    label = gets.chomp

    # Create a new book and add it to the books list
    book = Book.new(author, title, publisher, publish_date, genre, cover_state, label)
    @books << book

    puts 'Thanks! Your book has been created:'
    puts "0) Author: #{book.author}, Title: #{book.title}, Publisher: #{book.publisher}, " \
         "Genre: #{book.genre}, Cover_state: #{book.cover_state}, Label: #{book.label}"
  end

  # If you're using this method in this class, it should be defined here as well.
  def format_item(index, item, *attributes)
    formatted_attrs = attributes.map { |attr| "#{attr.capitalize}: #{item.send(attr)}" }.join(', ')
    "#{index}) #{formatted_attrs}"
  end
end
