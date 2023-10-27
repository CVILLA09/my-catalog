class LabelManager
  attr_accessor :labels

  def initialize
    @labels = []
  end

  # Method to list all labels
  def list_labels_by_category(category)
    filtered_labels = @labels.select { |label| label.category == category }

    if filtered_labels.empty?
      puts "There are no labels for #{category} yet!"
    else
      puts "Labels for #{category}:"
      filtered_labels.each_with_index do |label, index|
        puts "#{index}) Title: #{label.title}, Color: #{label.color}"
      end
    end
  end
end
