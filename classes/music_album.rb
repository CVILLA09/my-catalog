require_relative 'item'
class MusicAlbum < Item
    attr_accessor :album, :artist, :genre, :on_spotify, :label, :publish_date
  
    def initialize(album, artist, genre, on_spotify, label, publish_date)
      super(publish_date) # Pass the publish_date to the parent class constructor
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
  