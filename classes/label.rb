class Label
  attr_accessor :title, :color, :category

  def initialize(title, color)
    @title = title
    @color = color
    @items = []
  end

  def to_s
    "Title: #{@title}, Color: #{@color}"
  end

  def add_item(item, category)
    @items << item
    item.label = self
    @category = category
  end
end
