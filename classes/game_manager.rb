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
          puts format_item(index, game, :title, :author, :genre, :multiplayer, :last_played, :label)
        end
      end
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
      @games << game
  
      puts 'Thanks! Your game has been created:'
      puts "0) Title: #{game.title}, Author: #{game.author}, Genre: #{game.genre}, Multiplayer: #{game.multiplayer}, Last played: #{game.last_played}, Label: #{game.label}"
    end
  
    def format_item(index, item, *attributes)
      formatted_attrs = attributes.map { |attr| "#{attr.capitalize}: #{item.send(attr)}" }.join(', ')
      "#{index}) #{formatted_attrs}"
    end
  end
  