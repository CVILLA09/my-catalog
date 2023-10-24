require 'date'

class Item

    ## Attributes
    attr_reader :id
    attr_accessor :publish_date, :archived, :genre, :author, :label

    def initialize(publish_date, archived: false, id: nil)
        @id = Random.rand(1000)
        @publish_date = Date.strptime(publish_date, "%Y/%m/%d")
        @archived = archived
    end

    ## Methods
    def can_be_archived?
        ## Should return true if published_date is older than 10 years
        Date.today.year - @publish_date.year > 10
    end

    def move_to_archive
        @archived = true if can_be_archived?
    end


end

test_item = Item.new("2013/02/05")
test_item.genre = "Rock"

puts test_item.genre
puts test_item.id
