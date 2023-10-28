require 'json'
require_relative 'music_album'
require_relative 'label'
require_relative 'author'

class MusicAlbumManager
  attr_reader :albums

  def initialize(label_manager, author_manager, genre_manager)
    @label_manager = label_manager
    @author_manager = author_manager
    @genre_manager = genre_manager
    @albums = []
    load_music_albums
  end

  def list_music_albums
    if @albums.empty?
      puts 'There are no music albums yet!'
    else
      puts 'List of all music albums:'
      @albums.each_with_index do |album, index|
        puts format_item(index, album, :album, :artist, :genre, :publish_date, :on_spotify, :label)
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
    print 'Publish Date (YYYY/MM/DD): '
    publish_date = gets.chomp
    print 'On Spotify?(Y/N): '
    on_spotify = gets.chomp.downcase == 'y'
    print 'Label: '
    label = gets.chomp

    # Handle Genre
    genre_obj = @genre_manager.find_or_create_genre(genre, 'Music Albums')
    # Handle Author
    artist_created = Author.new(artist, '')
    @author_manager.add_author(artist_created, 'Music Albums')
    # Handle Label
    label_obj = Label.new(label, 'green')
    label_obj.category = 'Music Albums'
    @label_manager.labels << label_obj


    attributes = {
      album: album,
      artist: artist_created,
      genre: genre_obj,
      on_spotify: on_spotify,
      label: label_obj, # TODO ,
      publish_date: publish_date
    }
    music_album = MusicAlbum.new(attributes)
    @albums << music_album
    puts 'Thanks! Your music album has been created:'
    puts format_item(@albums.size - 1, music_album, :album, :artist, :genre, :publish_date, :on_spotify, :label)
  end

  def format_item(index, item, *attributes)
    formatted_attrs = attributes.map do |attr|
      value = item.send(attr)
      case attr
      when :genre
        "Genre: #{value.name if value.is_a?(Genre)}"
      when :author
        "Author: #{value.first_name} #{value.last_name if value.is_a?(Author)}"
      when :label
        "Label: #{value.title if value.is_a?(Label)}"
      else
        "#{attr.capitalize}: #{value}"
      end
    end.join(', ')
    "#{index}) #{formatted_attrs}"
  end

  def load_music_albums
    return unless File.exist?('./data/music_albums.json')

    begin
      music_album_data = JSON.parse(File.read('./data/music_albums.json'))
      if music_album_data.is_a?(Array)
        music_album_data.each do |album_data|
          load_single_music_album(album_data)
        end
      else
        puts 'No music albums found in the JSON file.'
      end
    rescue JSON::ParserError => e
      puts "Error parsing JSON: #{e.message}"
    rescue StandardError => e
      puts "An error occurred: #{e.message}"
    end
  end

  def load_single_music_album(album_data)
    if album_data['publish_date'].nil?
      puts "Warning: 'publish_date' is missing for an album."
      return
    end

    # Handle Genre
    genre = @genre_manager.find_or_create_genre(album_data['genre'], 'Music Albums')
    # Handle Author
    artist_created = Author.new(album_data['artist'], '')
    @author_manager.add_author(artist_created, 'Music Albums')
    # Handle Label
    label_obj = Label.new(album_data['label'], 'green')
    label_obj.category = 'Music Albums'
    @label_manager.labels << label_obj
  

    attributes = {
      album: album_data['album'],
      artist: artist_created,
      genre: genre,
      on_spotify: album_data['on_spotify'],
      label: label_obj,
      publish_date: album_data['publish_date']
    }
    music_album = MusicAlbum.new(attributes)
    @albums << music_album
  end

  def save_music_albums
    if @albums.empty?
      puts 'No music albums to save.'
      return
    end
    music_album_data = @albums.map do |album|
      {
        'album' => album.album,
        'artist' => album.artist.first_name,
        'genre' => album.genre.name,
        'on_spotify' => album.on_spotify,
        'label' => album.label.title,
        'publish_date' => album.publish_date
      }
    end
    File.write('./data/music_albums.json', music_album_data.to_json)
    puts 'Music albums saved successfully.'
  end
end
