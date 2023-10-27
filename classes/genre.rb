class Genre
  attr_reader :id
  attr_accessor :name, :category, :items

  def initialize(name, category)
    @id = Random.rand(1000)
    @name = name
    @category = category
    @items = []
  end

  def add_item(item)
    @items << item
    item.genre = self
  end

  def to_json(*_args)
    {
      id: @id,
      name: @name,
      category: @category
    }
  end
end
