require_relative 'book'
require_relative 'label'

class BookManager
  def initialize(label_manager)
    @books = []
    @label_manager = label_manager
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
    author, title, publisher, publish_date, genre, cover_state, label = get_user_input
    create_and_add_book(author, title, publisher, publish_date, genre, cover_state, label)
  end

  def get_user_input
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
    [author, title, publisher, publish_date, genre, cover_state, label]
  end

  def create_and_add_book(author, title, publisher, publish_date, genre, cover_state, label)
    new_label = Label.new(label, 'red')
    @label_manager.labels << new_label

    book = Book.new(publish_date, title, publisher, cover_state, archived: false)
    book.author = author
    book.title = title
    book.genre = genre
    book.label = new_label

    @books << book

    puts 'Thanks! Your book has been created:'
    puts format_item(@books.length - 1, book, :author, :title, :publisher, :genre, :cover_state, :label)
  end

  def format_item(index, item, *attributes)
    formatted_attrs = attributes.map { |attr| "#{attr.capitalize}: #{item.send(attr)}" }.join(', ')
    "#{index}) #{formatted_attrs}"
  end
end
