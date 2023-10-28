# music_album_manager_spec.rb

require 'json'
require_relative '../classes/music_album_manager'
require_relative '../classes/label_manager'
require_relative '../classes/genre_manager'
require_relative '../classes/author_manager'

describe MusicAlbumManager do
  before(:each) do
    @label_manager = LabelManager.new # You'll need to create LabelManager and other dependencies
    @author_manager = AuthorManager.new
    @genre_manager = GenreManager.new
    @music_album_manager = MusicAlbumManager.new(@label_manager, @author_manager, @genre_manager)
  end

  describe '#add_music_album' do
    it 'adds a music album to the collection' do
      album_data = [
        'Test Album',
        'Test Artist',
        'Test Genre',
        '2023/10/28', # Use a valid date format
        'Y', # Assume it's on Spotify
        'Test Label'
      ]

      # Stub gets method to provide input
      allow(@music_album_manager).to receive(:gets).and_return(*album_data)

      # Add debugging output
      puts "Before adding album: #{@music_album_manager.albums}"

      expect { @music_album_manager.add_music_album }.to output(/Thanks! Your music album has been created:/).to_stdout

      puts "After adding album: #{@music_album_manager.albums}"

      # Your expect statements
      added_album = @music_album_manager.albums.first
      expect(added_album.album).to eq('Test Album')
      expect(added_album.artist.first_name).to eq('Test Artist')
      expect(added_album.genre.name).to eq('Test Genre')
      expect(added_album.on_spotify).to be(true)
      expect(added_album.label.title).to eq('Test Label')
      expect(added_album.publish_date).to eq('2023/10/28')
    end
  end
end
