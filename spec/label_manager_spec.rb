require 'rspec'
require_relative '../classes/label_manager'
require_relative '../classes/label'

describe LabelManager do
  let(:label_manager) { LabelManager.new }

  describe '#initialize' do
    it 'creates a new LabelManager instance with an empty labels array' do
      expect(label_manager).to be_an_instance_of(LabelManager)
      expect(label_manager.labels).to be_empty
    end
  end

  it 'prints a message when there are no labels for the category' do
    expect do
      label_manager.list_labels_by_category('Category C')
    end.to output("There are no labels for Category C yet!\n").to_stdout
  end
end
