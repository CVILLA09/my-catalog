require_relative 'item'
class MusicAlbum < Item
  attr_accessor :album, :artist, :genre, :on_spotify, :label

  def initialize(attributes = {})
    super(attributes[:publish_date])
    @album = attributes[:album]
    @artist = attributes[:artist]
    @genre = attributes[:genre]
    @on_spotify = attributes[:on_spotify]
    @label = attributes[:label]
  end

  def can_be_archived?
    super && @on_spotify
  end
end
