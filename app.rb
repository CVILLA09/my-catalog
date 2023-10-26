require_relative 'classes/item'
require_relative 'classes/book_manager'
require_relative 'classes/music_album_manager'
require_relative 'classes/game_manager'
require_relative 'classes/genre_manager'

class ConsoleApp
  def initialize
    @book_manager = BookManager.new
    @music_album_manager = MusicAlbumManager.new
    @game_manager = GameManager.new
    @genres = GenreManager.new
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
    actions = {
      1 => method(:list_books),
      2 => method(:list_music_albums),
      3 => method(:list_games),
      4 => method(:list_genres),
      5 => method(:list_labels),
      6 => method(:list_authors),
      7 => method(:add_book),
      8 => method(:add_music_album),
      9 => method(:add_game),
      10 => method(:exit_app)
    }

    if actions.include?(choice)
      actions[choice].call
    else
      invalid_choice
    end
  end

  def list_books
    @book_manager.list_books
  end

  def list_music_albums
    @music_album_manager.list_music_albums
  end

  def list_games
    @game_manager.list_games
  end

  def add_book
    @book_manager.add_book
  end

  def add_music_album
    @music_album_manager.add_music_album
  end

  def add_game
    @game_manager.add_game
  end

  def exit_app
    puts 'Thank you for using our app "My Catalog of Things"! Goodbye!'
    @music_album_manager.save_music_albums
    exit
  end

  def invalid_choice
    puts 'Invalid choice. Please select a valid option.'
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
