require_relative 'item'

class Book < Item
  attr_accessor :title, :publisher, :cover_state

  def initialize(publish_date, title, publisher, cover_state, archived: false)
    super(publish_date, archived: archived)
    @title = title
    @publisher = publisher
    @cover_state = cover_state
  end

  def can_be_archived?
    super || @cover_state == 'bad'
  end
end
