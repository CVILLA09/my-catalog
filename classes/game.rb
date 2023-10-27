require_relative 'item'
require_relative 'author'
require_relative 'label'
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

  def label=(value)
    raise 'Invalid label' unless value.is_a?(Label)

    value.category = 'Games'
    @label = value
  end

  def can_be_archived?
    Date.today.year - @last_played_at.year > 2 && super
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end

  def to_json(*_args)
    {
      id: @id,
      title: @title,
      last_played_at: @last_played_at.to_s.gsub('-', '/'),
      multiplayer: @multiplayer,
      genre: @genre.to_json,
      label: @label.to_json,
      source: @source,
      author: @author.to_json
    }
  end
end
