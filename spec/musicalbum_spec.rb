# music_album_spec.rb

require 'json'
require_relative '../classes/music_album'

describe MusicAlbum do
  describe '#can_be_archived?' do
    context 'when the album is on Spotify and can be archived' do
      it 'returns true' do
        attributes = {
          album: 'Test Album',
          artist: 'Test Artist',
          genre: 'Test Genre',
          publish_date: '2023/10/28',
          on_spotify: true,
          label: 'Test Label'
        }
        MusicAlbum.new(attributes)
      end
    end

    context 'when the album is not on Spotify' do
      it 'returns false' do
        attributes = {
          album: 'Test Album',
          artist: 'Test Artist',
          genre: 'Test Genre',
          publish_date: '2023/10/28',
          on_spotify: false,
          label: 'Test Label'
        }
        music_album = MusicAlbum.new(attributes)

        expect(music_album.can_be_archived?).to be(false)
      end
    end

    context 'when the album is on Spotify but cannot be archived yet' do
      it 'returns false' do
        attributes = {
          album: 'Test Album',
          artist: 'Test Artist',
          genre: 'Test Genre',
          publish_date: '2023/12/01', # Future date
          on_spotify: true,
          label: 'Test Label'
        }
        music_album = MusicAlbum.new(attributes)

        expect(music_album.can_be_archived?).to be(false)
      end
    end
  end
end
