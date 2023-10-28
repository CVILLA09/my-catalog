require 'rspec'
require_relative '../classes/label_manager'

# Define a simple Label class for testing
class Label
  attr_accessor :title, :color, :category

  def initialize(title, color, category)
    @title = title
    @color = color
    @category = category
  end
end

describe LabelManager do
  let(:label_manager) { LabelManager.new }

  describe '#initialize' do
    it 'creates a new LabelManager instance with an empty labels array' do
      expect(label_manager).to be_an_instance_of(LabelManager)
      expect(label_manager.labels).to be_empty
    end
  end

  describe '#list_labels_by_category' do
    it 'lists labels by category when labels exist' do
      # Add some labels to the manager
      label_manager.labels << Label.new('Label 1', 'Red', 'Category A')
      label_manager.labels << Label.new('Label 2', 'Blue', 'Category B')
      label_manager.labels << Label.new('Label 3', 'Green', 'Category A')
      output_message = "Labels for Category A:\n0) Title: Label 1, Color: Red\n1) Title: Label 3, Color: Green\n"

      expect do
        label_manager.list_labels_by_category('Category A')
      end.to output(output_message).to_stdout
    end

    it 'prints a message when there are no labels for the category' do
      expect do
        label_manager.list_labels_by_category('Category C')
      end.to output("There are no labels for Category C yet!\n").to_stdout
    end
  end
end
