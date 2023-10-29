require 'rspec'
require 'json'
require './classes/genre'
require './classes/genre_manager'

describe GenreManager do
  before(:each) do
    @genre_manager = GenreManager.new
  end

  it 'should find or create a genre' do
    genre = @genre_manager.find_or_create_genre('Adventure', 'Movies')
    expect(genre.name).to eq('Adventure')
    expect(genre.category).to eq('Movies')
    expect(@genre_manager.genres.length).to eq(1)

    # Attempt to find an existing genre
    genre2 = @genre_manager.find_or_create_genre('Adventure', 'Movies')
    expect(genre2).to eq(genre) # Should return the existing genre
  end
end
