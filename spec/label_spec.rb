require 'rspec'
require './classes/label'

describe Label do
  let(:label) { Label.new('Label 1', 'Red') }
  let(:item) { double('Item') }

  describe '#initialize' do
    it 'creates a new Label instance with title and color' do
      expect(label.title).to eq('Label 1')
      expect(label.color).to eq('Red')
      expect(label.category).to be_nil
      expect(label.instance_variable_get(:@items)).to be_empty
    end
  end

  describe '#add_item' do
    it 'adds an item to the label and sets the item\'s label and category' do
      category = 'Category A'
      allow(item).to receive(:label=) # Mock the label= method

      label.add_item(item, category)

      expect(label.instance_variable_get(:@items)).to include(item)
      expect(item).to have_received(:label=).with(label)
      expect(label.category).to eq(category)
    end
  end
end
