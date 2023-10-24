require_relative 'classes/item'

class ConsoleApp
  def initialize
    @items = []
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
      list_books
    when 2
      list_music_albums
    when 3
      list_games
    when 4
      list_genres
    when 5
      list_labels
    when 6
      list_authors
    when 7
      add_book
    when 8
      add_music_album
    when 9
      add_game
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

  def list_books
    if @items.empty?
      puts 'There are no books yet!'
    else
      puts 'List of all books:'
      @items.each_with_index do |book, index|
        puts format_item(index, book, :author, :title, :publisher, :genre, :cover_state, :label)
      end
    end
  end

  def list_music_albums
    if @items.empty?
      puts 'There are no music albums yet!'
    else
      puts 'List of all music albums:'
      @items.each_with_index do |album, index|
        puts format_item(index, album, :album, :artist, :genre, :on_spotify, :label)
      end
    end
  end

  def list_games
    if @items.empty?
      puts 'There are no games yet!'
    else
      puts 'List of all games:'
      @items.each_with_index do |game, index|
        puts format_item(index, game, :title, :author, :genre, :multiplayer, :last_played, :label)
      end
    end
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

    # Create a new book and add it to the items list
    book = Book.new(author, title, publisher, publish_date, genre, cover_state, label)
    @items << book

    puts 'Thanks! Your book has been created:'
    puts "0) Author: #{book.author}, Title: #{book.title}, Publisher: #{book.publisher}, Genre: #{book.genre}, Cover_state: #{book.cover_state}, Label: #{book.label}"
  end

  def add_music_album
    puts 'Enter the details for the music album:'
    print 'Album: '
    album = gets.chomp
    print 'Artist: '
    artist = gets.chomp
    print 'Genre: '
    genre = gets.chomp
    print 'On Spotify?(Y/N): '
    on_spotify = gets.chomp
    print 'Label: '
    label = gets.chomp

    # Create a new music album and add it to the items list
    music_album = MusicAlbum.new(album, artist, genre, on_spotify, label)
    @items << music_album

    puts 'Thanks! Your music album has been created:'
    puts "0) Album: #{music_album.album}, Artist: #{music_album.artist}, Genre: #{music_album.genre}, On_Spotify: #{music_album.on_spotify}, Label: #{music_album.label}"
  end

  def add_game
    puts 'Enter the details for the game:'
    print 'Title: '
    title = gets.chomp
    print 'Author: '
    author = gets.chomp
    print 'Genre: '
    genre = gets.chomp
    print 'Multiplayer?(Y/N): '
    multiplayer = gets.chomp
    print 'Last played: '
    last_played = gets.chomp
    print 'Label: '
    label = gets.chomp

    # Create a new game and add it to the items list
    game = Game.new(title, author, genre, multiplayer, last_played, label)
    @items << game

    puts 'Thanks! Your game has been created:'
    puts "0) Title: #{game.title}, Author: #{game.author}, Genre: #{game.genre}, Multiplayer: #{game.multiplayer}, Last played: #{game.last_played}, Label: #{game.label}"
  end
end
