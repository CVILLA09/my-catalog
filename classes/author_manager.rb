require_relative 'author'

class AuthorManager
  attr_accessor :authors

  def initialize
    @authors = []
  end

  def add_author(author, category)
    raise 'Invalid author' unless author.is_a?(Author)
  
    author.category = category
    @authors << author
  end  

  def list_authors
    if @authors.empty?
      puts 'There are no authors yet!'
    else
      puts 'List of all authors:'
      @authors.each do |author|
        puts "First Name: #{author.first_name}, Last Name: #{author.last_name}"
      end
    end
  end
end
