require 'rspec'
require 'date'
require_relative '../classes/book'

RSpec.describe Book do
  describe '#initialize' do
    it 'creates a new book with the provided attributes' do
      attributes = {
        publish_date: '2023-01-01',
        title: 'The Great Gatsby',
        publisher: 'Scribner',
        cover_state: 'Good'
      }

      book = Book.new(
        attributes[:publish_date],
        attributes[:title],
        attributes[:publisher],
        attributes[:cover_state]
      )

      expect(book.publish_date.to_s).to eq(attributes[:publish_date]) # Ensure it's a string
      expect(book.title).to eq(attributes[:title])
      expect(book.publisher).to eq(attributes[:publisher])
      expect(book.cover_state).to eq(attributes[:cover_state])
    end
  end
end
