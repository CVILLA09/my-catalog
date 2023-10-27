require_relative 'item'
class MusicAlbum < Item
  attr_accessor :album, :artist, :genre, :on_spotify, :label, :publish_date

  def initialize(album, artist, genre, on_spotify, label, publish_date)
    super(publish_date)
    @album = album
    @artist = artist
    @genre = genre
    @on_spotify = on_spotify
    @label = label
  end

  def can_be_archived?
    super && @on_spotify
  end
end
music_album = MusicAlbum.new('sasfd', 'asdt', 'gfhg', 'n', 'gh', '2020-05/07')
puts music_album.publish_date
