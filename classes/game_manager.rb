require_relative 'game'
require_relative 'author'
require_relative 'author_manager'
require 'json'

class GameManager
  attr_accessor :games

  def initialize(author_manager, label_manager)
    @author_manager = author_manager
    @label_manager = label_manager
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
        game.genre = game_data['genre']
        game.label = game_data['label']
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

  def list_authors
    @author_manager.authors.each_with_index do |author, index|
      puts "#{index}) First Name: #{author.first_name}, Last Name: #{author.last_name}"
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
    game.author = Author.new(details[:author_name], details[:author_last_name])
    @author_manager.add_author(game.author, 'Games')
    game.genre = details[:genre]

    # Check if label already exists or create a new one
    existing_label = @label_manager.labels.find { |label| label.title.downcase == details[:label].downcase }

    if existing_label.nil?
      new_label = Label.new(details[:label], 'blue')
      new_label.category = 'Games'
      @label_manager.labels << new_label
      game.label = new_label
    else
      game.label = existing_label
    end

    game
  end

  def display_game_info(game)
    puts 'Thanks! Your game has been created:'
    puts "0) Title: #{game.title}, Author: #{game.author.first_name} #{game.author.last_name}, Genre: #{game.genre}, " \
         "Multiplayer: #{game.multiplayer}, Last played: #{game.last_played_at}, Label: #{game.label}"
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
