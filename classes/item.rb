require 'date'
require_relative 'author'

class Item
  ## Attributes
  attr_reader :id
  attr_accessor :publish_date, :archived

  def initialize(publish_date, archived: false)
    @id = Random.rand(1000)
    @publish_date = Date.strptime(publish_date, '%Y/%m/%d')
    @archived = archived
  end

  # Custom setter methods
  def genre=(value)
    @genre = value.strip.capitalize
  end

  def author=(value)
    @author = value.strip.capitalize
  end

  def label=(value)
    @label = if value.is_a?(Label)
               value
             else
               value.strip.upcase
             end
  end

  def source=(value)
    @source = value.strip.capitalize
  end

  ## Methods
  def can_be_archived?
    # Should return true if published_date is older than 10 years
    Date.today.year - @publish_date.year > 10
  end

  def move_to_archive
    @archived = true if can_be_archived?
  end
end
