require_relative 'item'
require_relative 'author'
require 'date'
class Game < Item
  attr_accessor :last_played_at, :title, :multiplayer, :genre, :label, :source
  attr_reader :author

  def initialize(last_played_at, multiplayer)
    super(last_played_at)
    @last_played_at = Date.strptime(last_played_at, '%Y/%m/%d')
    @multiplayer = multiplayer
  end

  def author=(value)
    raise 'Invalid author' unless value.is_a?(Author)

    value.category = 'Games'
    @author = value
  end

  def can_be_archived?
    Date.today.year - @last_played_at.year > 2 && super
  end
end
