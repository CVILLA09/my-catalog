require 'json'
require_relative 'genre'

class GenreManager
  attr_reader :genres

  def initialize
    @genres = []
    # load_genres
  end

  def add_genre(name, category)
    genre = Genre.new(name, category)
    @genres << genre
    save_genres
    puts "Genre '#{name}' in the category of '#{category}' has been added."
  end

  def find_or_create_genre(name, category)
    existing_genre = @genres.find do |genre|
      genre.name.downcase == name.downcase && genre.category.downcase == category.downcase
    end
    return existing_genre if existing_genre

    new_genre = Genre.new(name, category)
    @genres << new_genre
    # save_genres
    new_genre
  end

end
