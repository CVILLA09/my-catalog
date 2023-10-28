require './classes/book_manager'
require './classes/label_manager'
require './classes/author_manager'
require './classes/genre_manager'

describe BookManager do
  let(:label_manager) { LabelManager.new }
  let(:author_manager) { AuthorManager.new }
  let(:genre_manager) { GenreManager.new }
  let(:book_manager) { BookManager.new(label_manager, author_manager, genre_manager) }

  it 'creates a new BookManager' do
    expect(book_manager).to be_an_instance_of(BookManager)
  end
end
