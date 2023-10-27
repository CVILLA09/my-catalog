require_relative 'item'

class Book < Item
  attr_accessor :title, :publisher, :cover_state
  attr_reader :author, :genre, :label

  def initialize(publish_date, title, publisher, cover_state, archived: false)
    super(publish_date, archived: archived)
    @title = title
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end

  def to_h
    {
      'author_first_name' => @author.first_name,
      'author_last_name' => @author.last_name,
      'title' => @title,
      'publisher' => @publisher,
      'publish_date' => @publish_date,
      'genre' => @genre,
      'cover_state' => @cover_state,
      'label_title' => @label.title,
      'label_color' => @label.color,
      'archived' => @archived
    }
  end  
end
