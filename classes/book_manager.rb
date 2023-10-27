require_relative 'book'
require_relative 'label'
require_relative 'author'
require_relative 'author_manager'
require 'json'

class BookManager
  def initialize(label_manager, author_manager)
    @label_manager = label_manager
    @author_manager = author_manager
    @books = []
    load_books_from_json
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
    print 'Title: '
    attributes[:title] = gets.chomp
    print 'Author First Name: '
    author_first_name = gets.chomp.strip
    print 'Author Last Name: '
    author_last_name = gets.chomp.strip
    attributes[:author] = "#{author_first_name} #{author_last_name}"
    %w[Publisher Publish_Date Genre Cover_State Label].each do |field|
      print "#{field}: "
      attributes[field.downcase.to_sym] = gets.chomp
    end
    attributes
  end

  def create_and_add_book(attributes)
    existing_label = @label_manager.labels.find { |label| label.title.downcase == attributes[:label].downcase }

    if existing_label.nil?
      new_label = Label.new(attributes[:label], 'red')
      new_label.category = 'Books'
      @label_manager.labels << new_label
      label_for_book = new_label
    else
      label_for_book = existing_label
    end

    book = Book.new(attributes[:publish_date], attributes[:title], attributes[:publisher], attributes[:cover_state],
                    archived: false)
    author_first_name, author_last_name = attributes[:author].split
    author = Author.new(author_first_name, author_last_name)
    @author_manager.add_author(author, 'Books')
    book.author = author
    book.title = attributes[:title]
    book.genre = attributes[:genre]
    book.label = label_for_book

    @books << book

    # Save books to JSON file after successfully adding a new book
    save_books_to_json

    puts 'Thanks! Your book has been created:'
    puts format_item(@books.length - 1, book, :author, :title, :publisher, :genre, :cover_state, :label)
  end

  def format_item(index, item, *attributes)
    formatted_attrs = attributes.map { |attr| "#{attr.capitalize}: #{item.send(attr)}" }.join(', ')
    "#{index}) #{formatted_attrs}"
  end

  def save_books_to_json
    File.open('data/books.json', 'w') do |f|
      f.write(JSON.pretty_generate(@books.map(&:to_h)))
    end
  end  

  def load_books_from_json
    if File.exist?('data/books.json')
      json_data = File.read('data/books.json')
      array_of_hashes = JSON.parse(json_data)
      @books = array_of_hashes.map do |book_hash|
        book = Book.new(book_hash['publish_date'], book_hash['title'], book_hash['publisher'], book_hash['cover_state'], archived: book_hash['archived'])
        
        author = Author.new(book_hash['author_first_name'], book_hash['author_last_name'])
        @author_manager.add_author(author, 'Books')
        book.author = author
        
        existing_label = @label_manager.labels.find { |label| label.title.downcase == book_hash['label_title'].downcase }
        if existing_label.nil?
          new_label = Label.new(book_hash['label_title'], book_hash['label_color'])
          new_label.category = 'Books'
          @label_manager.labels << new_label
          book.label = new_label
        else
          book.label = existing_label
        end
        
        book.genre = book_hash['genre']
        book
      end
    end
  end  
end
