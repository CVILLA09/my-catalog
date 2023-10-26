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
    attributes = collect_user_input
    create_and_add_book(attributes)
  end

  def collect_user_input
    puts 'Enter the details for the book:'
    attributes = {}
    %w[Author Title Publisher Publish_Date Genre Cover_State Label].each do |field|
      print "#{field}: "
      attributes[field.downcase.to_sym] = gets.chomp
    end
    attributes
  end

  def create_and_add_book(attributes)
    new_label = Label.new(attributes[:label], 'red')
    @label_manager.labels << new_label

    book = Book.new(attributes[:publish_date], attributes[:title], attributes[:publisher], attributes[:cover_state],
                    archived: false)
    book.author = attributes[:author]
    book.title = attributes[:title]
    book.genre = attributes[:genre]
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
