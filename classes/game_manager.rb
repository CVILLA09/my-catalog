require_relative 'game'
require_relative 'author'
require_relative 'label'
require_relative 'author_manager'
require_relative 'label_manager'
require_relative 'genre_manager'
require 'json'

class GameManager
  attr_accessor :games

  def initialize(label_manager, author_manager, genre_manager)
    @author_manager = author_manager
    @label_manager = label_manager
    @genre_manager = genre_manager
    @games = []
    load_games
  end

  def load_games
    return unless File.exist?('data/games.json')

    if File.empty?('data/games.json')
      puts 'The file is empty'
    else
      data = JSON.parse(File.read('data/games.json'))
      data.each do |game_data|
        game = Game.new(game_data['last_played_at'], game_data['multiplayer'])
        game.title = game_data['title']
        game.author = Author.new(game_data['author']['first_name'], game_data['author']['last_name'])
        @author_manager.add_author(game.author, 'Games')

        # Handle Genre
        genre = @genre_manager.find_or_create_genre(game_data['genre'], 'Games')
        game.genre = genre

        game.label = Label.new(game_data['label']['title'], game_data['label']['color'])
        game.label.category = 'Games'
        @label_manager.labels << game.label
        @games << game
      end
    end
  end

  def save_games
    File.write('data/games.json', JSON.pretty_generate(@games.map(&:to_json)))
  end

  def list_games
    if @games.empty?
      puts 'There are no games yet!'
    else
      puts 'List of all games:'
      @games.each_with_index do |game, index|
        puts format_item(index, game, :title, :author, :genre, :multiplayer, :last_played_at, :label)
      end
    end
  end

  def add_game
    puts 'Enter the details for the game:'
    game_details = game_details_input
    game = create_game(game_details)
    @games << game
    display_game_info(game)
  end

  def game_details_input
    print 'Title: '
    title = gets.chomp
    print 'Author First Name: '
    author_first_name = gets.chomp
    print 'Author Last Name: '
    author_last_name = gets.chomp
    print 'Genre: '
    genre = gets.chomp
    print 'Multiplayer?(Y/N): '
    multiplayer = gets.chomp.upcase == 'Y'
    print 'Last played: '
    last_played = gets.chomp
    print 'Label: '
    label = gets.chomp

    { title: title, author_first_name: author_first_name, author_last_name: author_last_name, genre: genre,
      multiplayer: multiplayer, last_played: last_played, label: label }
  end

  def create_game(details)
    game = Game.new(details[:last_played], details[:multiplayer])
    game.title = details[:title]
    game.author = Author.new(details[:author_first_name], details[:author_last_name]) # Fix the key
    @author_manager.add_author(game.author, 'Games')

    # Handle Genre
    genre = @genre_manager.find_or_create_genre(details[:genre], 'Games')
    game.genre = genre

    game.label = Label.new(details[:label], 'red')
    game.label.category = 'Games'
    @label_manager.labels << game.label

    game
  end

  def display_game_info(game)
    puts 'Thanks! Your game has been created:'
    puts "0) Title: #{game.title}, Author: #{game.author.first_name} #{game.author.last_name}, Genre: #{game.genre.name}, " \
         "Multiplayer: #{game.multiplayer}, Last played: #{game.last_played_at}, Label: #{game.label.title}"
  end

  def format_item(index, item, *attributes)
    formatted_attrs = attributes.map do |attr|
      if attr == :author
        "Author: #{item.author.last_name} #{item.author.first_name}"
      else
        "#{attr.capitalize}: #{item.send(attr)}"
      end
    end.join(', ')
    "#{index}) #{formatted_attrs}"
  end
end
