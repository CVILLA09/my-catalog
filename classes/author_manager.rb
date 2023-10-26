require_relative 'author'

class AuthorManager
    attr_accessor :authors

    def initialize
        @authors = []  # Inicializa @authors como un Array vacío
    end

    def add_author(author)
        if author.is_a?(Author)
            author.category = 'Games'
            @authors << author
        else
            raise 'Invalid author'
        end
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