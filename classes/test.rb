require_relative 'game_manager'


game_manager = GameManager.new(AuthorManager.new)

game_manager.games.each do |game|
    puts game.author.first_name
    puts game.id
end


# data = File.read('games.json')
# games = JSON.parse(data)

# games.each do |game|
#     puts game['author']['first_name']
# end 



