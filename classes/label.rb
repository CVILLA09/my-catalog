class Label
  attr_accessor :title, :color

  def initialize(title, color)
    @title = title
    @color = color
    @items = []
  end

  def to_s
    "Title: #{@title}, Color: #{@color}"
  end

  def add_item(item)
    @items << item
    item.label = self
  end  
end
