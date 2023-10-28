# author_spec.rb

require 'rspec'
require './classes/author'
require './classes/item'

RSpec.describe Author do
  describe '#initialize' do
    it 'creates a new Author with the given first name' do
      author = Author.new('John')
      expect(author.first_name).to eq('John')
    end

    it 'creates a new Author with the given first and last names' do
      author = Author.new('John', 'Doe')
      expect(author.first_name).to eq('John')
      expect(author.last_name).to eq('Doe')
    end

    it 'generates a random ID' do
      author1 = Author.new('Alice')
      author2 = Author.new('Bob')
      expect(author1.id).not_to eq(author2.id)
    end

    it 'initializes items as an empty array' do
      author = Author.new('Jane')
      expect(author.items).to be_empty
    end

    it 'initializes category as nil' do
      author = Author.new('George')
      expect(author.category).to be_nil
    end
  end

  describe '#add_item' do
    it 'adds an item to the author and sets the item author' do
      author = Author.new('Mary')
      item = Item.new('Book')
      author.add_item(item)
      expect(author.items).to include(item)
      expect(item.author).to eq(author)
    end
  end

  describe '#to_s' do
    it 'returns the full name of the author' do
      author = Author.new('Robert', 'Smith')
      expect(author.to_s).to eq('Robert Smith')
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the author' do
      author = Author.new('Sarah', 'Johnson')
      author.category = 'Science'
      expect(author.to_json).to eq({
                                     id: author.id,
                                     first_name: 'Sarah',
                                     last_name: 'Johnson',
                                     category: 'Science'
                                   })
    end
  end
end
