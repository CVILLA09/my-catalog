class Label
    attr_accessor :title, :color
  
    def initialize(title, color)
      @title = title
      @color = color
    end
  
    def to_s
      "Title: #{@title}, Color: #{@color}"
    end
  end
  