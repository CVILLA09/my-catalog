require 'rspec'
require './classes/game'
require './classes/author'
require './classes/label'
require './classes/genre'
require './classes/author_manager'
require './classes/label_manager'
require './classes/genre_manager'
require './classes/game_manager'

describe GameManager do
  let(:label_manager) { LabelManager.new }
  let(:author_manager) { AuthorManager.new }
  let(:genre_manager) { GenreManager.new }
  let(:game_manager) { GameManager.new(label_manager, author_manager, genre_manager) }


  it 'loads games from JSON' do
    sample_game_data = [
      {
        'title' => 'Test Game 1',
        'author' => {
          'first_name' => 'John',
          'last_name' => 'Doe'
        },
        'genre' => {
          'name' => 'Action'
        },
        'multiplayer' => true,
        'last_played_at' => '2023/10/28',
        'label' => {
          'title' => 'Test Label',
          'color' => 'red'
        }
      }
    ]
    allow(File).to receive(:exist?).and_return(true)
    allow(File).to receive(:read).and_return(JSON.generate(sample_game_data))

    game_manager.load_games

    expect(game_manager.games).not_to be_empty
    expect(game_manager.games.first.last_played_at).to eq(Date.strptime('2023-10-28', '%Y-%m-%d'))
  end
end
