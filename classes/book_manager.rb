require_relative 'book'

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
    book = Book.new(publish_date, title, publisher, cover_state, archived: false)
    book.author = author
    book.title = title
    book.genre = genre
    book.label = label
    
    @books << book
  
    puts 'Thanks! Your book has been created:'
    puts format_item(@books.length - 1, book, :author, :title, :publisher, :genre, :cover_state, :label)
  end  

  def format_item(index, item, *attributes)
    formatted_attrs = attributes.map { |attr| "#{attr.capitalize}: #{item.send(attr)}" }.join(', ')
    "#{index}) #{formatted_attrs}"
  end
end
