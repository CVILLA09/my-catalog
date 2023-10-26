class Author
    attr_reader :id, :first_name, :last_name
    attr_accessor :items, :category
  
    def initialize(first_name, last_name)
        @id = Random.rand(1000)
        @first_name = first_name
        @last_name = last_name
        @category = nil
        @items = []
    end
  
    def add_item(item)
      @items << item
      item.author = self
    end
  end
  