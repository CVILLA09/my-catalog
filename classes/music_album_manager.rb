require 'json'
require_relative 'music_album'

class MusicAlbumManager
  attr_reader :albums

  def initialize
    @albums = []
    load_music_albums
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
    print 'Publish Date (YYYY/MM/DD): ' # Include the prompt for the publish date
    publish_date = gets.chomp
    print 'On Spotify?(Y/N): '
    on_spotify = gets.chomp.downcase == 'y'
    print 'Label: '
    label = gets.chomp
  
    music_album = MusicAlbum.new(album, artist, genre, on_spotify, label, publish_date) # Pass publish_date to the constructor
    @albums << music_album
  
    puts 'Thanks! Your music album has been created:'
    puts "0) Album: #{music_album.album}, Artist: #{music_album.artist}, Genre: #{music_album.genre}, " \
         "Publish Date: #{music_album.publish_date}, On_Spotify: #{music_album.on_spotify}, Label: #{music_album.label}"
  
    save_music_albums
  end
  

  def format_item(index, item, *attributes)
    formatted_attrs = attributes.map { |attr| "#{attr.capitalize}: #{item.send(attr)}" }.join(', ')
    "#{index}) #{formatted_attrs}"
  end

  def load_music_albums
    return unless File.exist?('music_albums.json')
  
    music_album_data = JSON.parse(File.read('music_albums.json'))
    music_album_data.each do |album_data|
      if album_data['publish_date'].nil?
        # Handle the case where 'publish_date' is not provided
        puts "Warning: 'publish_date' is missing for an album."
        next # Skip this album and continue with the next one
      end
  
      music_album = MusicAlbum.new(
        album_data['album'],
        album_data['artist'],
        album_data['genre'],
        album_data['on_spotify'],
        album_data['label'],
        Date.strptime(album_data['publish_date'], '%Y/%m/%d') # Parse the date string
      )
      @albums << music_album
    end
  end
  
  
  def save_music_albums
    music_album_data = @albums.map do |album|
      {
        'album' => album.album,
        'artist' => album.artist,
        'genre' => album.genre,
        'on_spotify' => album.on_spotify,
        'label' => album.label
      }
    end

    File.open('music_albums.json', 'w') do |file| 
      file.puts JSON.generate(music_album_data)
    end
  end
end
