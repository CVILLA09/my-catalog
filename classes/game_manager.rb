require_relative 'game'

class GameManager
  def initialize
    @games = []
  end

  def list_games
    if @games.empty?
      puts 'There are no games yet!'
    else
      puts 'List of all games:'
      @games.each_with_index do |game, index|
        puts format_item(index, game, :title, :genre, :multiplayer, :last_played_at, :label)
      end
    end
  end

  def add_game
    puts 'Enter the details for the game:'
    print 'Title: '
    title = gets.chomp
    print 'Author name: '
    author_name = gets.chomp
    print 'Author last name: '
    author_last_name = gets.chomp
    print 'Genre: '
    genre = gets.chomp
    print 'Multiplayer?(Y/N): '
    multiplayer = gets.chomp.upcase == 'Y' ? true : false
    print 'Last played: '
    last_played = gets.chomp
    print 'Label: '
    label = gets.chomp

    # Create a new game and add it to the items list
    game = Game.new(last_played)
    game.title = title
    game.author = Author.new(author_name, author_last_name)
    game.genre = genre
    game.multiplayer = multiplayer
    game.label = label  ## Fix it
    @games << game

    puts 'Thanks! Your game has been created:'
    puts "0) Title: #{game.title}, Author: #{game.author.first_name} #{game.author.last_name}, Genre: #{game.genre}, " \
         "Multiplayer: #{game.multiplayer}, Last played: #{game.last_played_at}, Label: #{game.label}"
  end

  def format_item(index, item, *attributes)
    formatted_attrs = attributes.map { |attr| "#{attr.capitalize}: #{item.send(attr)}" }.join(', ')
    "#{index}) #{formatted_attrs}"
  end

end
