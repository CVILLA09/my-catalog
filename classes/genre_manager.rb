require 'json'

class GenreManager
  attr_reader :genres

  def initialize
    @genres = []
    load_genres
  end

  def list_genres
    if @genres.empty?
      puts 'No genres found.'
    else
      puts 'List of Genres:'
      @genres.each do |genre|
        puts "Name: #{genre.name}, Category: #{genre.category}, Number of Items: #{genre.items.count}"
      end
    end
  end

  def add_genre(name, category)
    genre = Genre.new(name, category)
    @genres << genre
    save_genres

    puts "Genre '#{name}' in the category of '#{category}' has been added."
  end

  def load_genres
    return unless File.exist?('genres.json')

    genre_data = JSON.parse(File.read('genres.json'))
    genre_data.each do |genre_info|
      genre = Genre.new(genre_info['name'], genre_info['category'])
      @genres << genre
    end
  end

  def save_genres
    genre_data = @genres.map do |genre|
      {
        'name' => genre.name,
        'category' => genre.category
      }
    end

    File.write('genres.json', JSON.generate(genre_data))
  end
end