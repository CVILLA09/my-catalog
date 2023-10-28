require 'json'
require_relative '../classes/music_album'
require_relative '../classes/music_album_manager'
require_relative '../classes/label_manager'
require_relative '../classes/genre_manager'
require_relative '../classes/author_manager'
require 'rspec'
describe MusicAlbumManager do
  before(:each) do
    # Configura los objetos necesarios para tus pruebas
    @label_manager = LabelManager.new
    @author_manager = AuthorManager.new
    @genre_manager = GenreManager.new
    @manager = MusicAlbumManager.new(@label_manager, @author_manager, @genre_manager)
  end
  describe '#add_music_album' do
    it 'adds an album to the list' do
      expect { @manager.add_music_album }.to change { @manager.albums.length }.by(1)
    end
  end
end
