require 'date'

class Item
  ## Attributes
  attr_reader :id
  attr_accessor :publish_date, :archived, :author

  def initialize(publish_date, archived: false)
    @id = Random.rand(1000)

    begin
      @publish_date = Date.strptime(publish_date, '%Y/%m/%d')
    rescue ArgumentError => e
      # Handle the error, for example, by setting publish_date to a default value or re-raising the exception.
      puts "Error parsing publish_date: #{e.message}"
      @publish_date = Date.today # Set it to the current date as a default.
    end

    @archived = archived
  end

  # Custom setter methods
  def genre=(value)
    @genre = value.strip.capitalize
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
