class LabelManager
    attr_accessor :labels
    
    def initialize
      @labels = []
    end
  
    # Method to list all labels
    def list_labels
      if @labels.empty?
        puts 'There are no labels yet!'
      else
        puts 'List of all labels:'
        @labels.each_with_index do |label, index|
          puts "#{index}) Title: #{label.title}, Color: #{label.color}"
        end
      end
    end
  end
  