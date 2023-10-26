require_relative 'item'
require_relative 'author'

class Game < Item
  attr_accessor :last_played_at, :title, :multiplayer

  def initialize(last_played_at, archived: false)
    super(last_played_at, archived: archived)
    @last_played_at = Date.strptime(last_played_at, '%Y/%m/%d')
  end

  def can_be_archived?
    Date.today.year - @last_played_at.year > 2  && super
  end
end
