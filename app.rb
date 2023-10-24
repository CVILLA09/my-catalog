require_relative 'classes/item'
require_relative 'classes/book_manager'
require_relative 'classes/music_album_manager'
require_relative 'classes/game_manager'

class ConsoleApp
  def initialize
    @book_manager = BookManager.new
    @music_album_manager = MusicAlbumManager.new
    @game_manager = GameManager.new
    @genres = []
    @labels = []
    @authors = []
  end

  def run
    puts 'Welcome to our app "My Catalog of Things"!'
    loop do
      display_menu
      print 'Select: '
      choice = gets.chomp.to_i
      process_choice(choice)
    end
  end
  
  def process_choice(choice)
    case choice
    when 1
      @book_manager.list_books
    when 2
      @music_album_manager.list_music_albums
    when 3
      @game_manager.list_games
    when 4
      list_genres
    when 5
      list_labels
    when 6
      list_authors
    when 7
      @book_manager.add_book
    when 8
      @music_album_manager.add_music_album
    when 9
      @game_manager.add_game
    when 10
      puts 'Thank you for using our app "My Catalog of Things"! Goodbye!'
      exit
    else
      puts 'Invalid choice. Please select a valid option.'
    end
  end

  def display_menu
    puts 'Please choose an option by entering a number:'
    puts '1 - List all books'
    puts '2 - List all music albums'
    puts '3 - List all games'
    puts '4 - List all genres'
    puts '5 - List all labels'
    puts '6 - List all authors'
    puts '7 - Add a book'
    puts '8 - Add a music album'
    puts '9 - Add a game'
    puts '10 - Exit'
  end

  def format_item(index, item, *attributes)
    formatted_attrs = attributes.map { |attr| "#{attr.capitalize}: #{item.send(attr)}" }.join(', ')
    "#{index}) #{formatted_attrs}"
  end

  def list_genres
    puts 'Select category for genres:'
    puts '1 - Books'
    puts '2 - Music Albums'
    puts '3 - Games'
    category_choice = gets.chomp.to_i

    case category_choice
    when 1
      display_genres(@genres.select { |genre| genre.category == 'Books' })
    when 2
      display_genres(@genres.select { |genre| genre.category == 'Music Albums' })
    when 3
      display_genres(@genres.select { |genre| genre.category == 'Games' })
    else
      puts 'Invalid category choice.'
    end
  end

  def display_genres(genres)
    puts 'Genres:'
    genres.each do |genre|
      puts "ID: #{genre.id}, Name: #{genre.name}, Items: #{genre.items.count}"
    end
    puts 'Press any key to return to the main menu'
    gets.chomp
  end

  def list_labels
    if @labels.empty?
      puts 'There are no labels yet!'
    else
      puts 'List of all labels:'
      @labels.each_with_index do |label, index|
        puts "#{index}) Title: #{label.title}, Color: #{label.color}"
      end
    end
  end

  def list_authors
    puts 'Select category for authors:'
    puts '1 - Books'
    puts '2 - Music Albums'
    puts '3 - Games'
    category_choice = gets.chomp.to_i

    case category_choice
    when 1
      display_authors(@authors.select { |author| author.category == 'Books' })
    when 2
      display_authors(@authors.select { |author| author.category == 'Music Albums' })
    when 3
      display_authors(@authors.select { |author| author.category == 'Games' })
    else
      puts 'Invalid category choice.'
    end
  end

  def display_authors(authors)
    puts 'Authors:'
    authors.each do |author|
      puts "First Name: #{author.first_name}, Last Name: #{author.last_name}"
    end
    puts 'Press any key to return to the main menu'
    gets.chomp
  end
end
