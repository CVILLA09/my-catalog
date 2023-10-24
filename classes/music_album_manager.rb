class MusicAlbumManager
  def initialize
    @albums = []
  end

  def list_music_albums
    if @albums.empty?
      puts 'There are no music albums yet!'
    else
      puts 'List of all music albums:'
      @albums.each_with_index do |album, index|
        puts format_item(index, album, :album, :artist, :genre, :on_spotify, :label)
      end
    end
  end

  def add_music_album
    puts 'Enter the details for the music album:'
    print 'Album: '
    album = gets.chomp
    print 'Artist: '
    artist = gets.chomp
    print 'Genre: '
    genre = gets.chomp
    print 'On Spotify?(Y/N): '
    on_spotify = gets.chomp
    print 'Label: '
    label = gets.chomp

    # Create a new music album and add it to the items list
    music_album = MusicAlbum.new(album, artist, genre, on_spotify, label)
    @albums << music_album

    puts 'Thanks! Your music album has been created:'
    puts "0) Album: #{music_album.album}, Artist: #{music_album.artist}, Genre: #{music_album.genre}, " \
         "On_Spotify: #{music_album.on_spotify}, Label: #{music_album.label}"
  end

  def format_item(index, item, *attributes)
    formatted_attrs = attributes.map { |attr| "#{attr.capitalize}: #{item.send(attr)}" }.join(', ')
    "#{index}) #{formatted_attrs}"
  end
end
