require './classes/author_manager'
require './classes/author'

describe AuthorManager do
  let(:author_manager) { AuthorManager.new }

  describe '#add_author' do
    it 'adds an author to the authors list with a category' do
      author = Author.new('John', 'Doe')
      category = 'Fiction'

      author_manager.add_author(author, category)

      expect(author_manager.authors).to include(author)
      expect(author.category).to eq(category)
    end

    it 'raises an error when trying to add an invalid author' do
      invalid_author = 'Not an Author'
      category = 'Fiction'

      expect { author_manager.add_author(invalid_author, category) }
        .to raise_error('Invalid author')
    end
  end

  describe '#list_authors' do
    it 'displays a message when there are no authors' do
      expect { author_manager.list_authors }.to output("There are no authors yet!\n").to_stdout
    end

    it 'lists authors when authors are present' do
      author1 = Author.new('Alice', 'Smith')
      author2 = Author.new('Bob', 'Johnson')
      category1 = 'Fiction'
      category2 = 'Non-fiction'

      author_manager.add_author(author1, category1)
      author_manager.add_author(author2, category2)

      expected_output = "List of all authors:\n" \
                        "First Name: Alice, Last Name: Smith\n" \
                        "First Name: Bob, Last Name: Johnson\n"

      expect { author_manager.list_authors }.to output(expected_output).to_stdout
    end
  end
end
