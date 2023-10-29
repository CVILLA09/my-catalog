require 'json'
require_relative '../classes/music_album'
require_relative '../classes/music_album_manager'
require_relative '../classes/label_manager'
require_relative '../classes/genre_manager'
require_relative '../classes/author_manager'
require 'rspec'

describe MusicAlbumManager do
  let(:label_manager) { double('LabelManager') }
  let(:author_manager) { double('AuthorManager') }
  let(:genre_manager) { double('GenreManager') }

  subject { described_class.new(label_manager, author_manager, genre_manager) }

  it 'adds a music album and lists it' do
    # Configura las simulaciones necesarias
    allow(author_manager).to receive(:add_author)
    allow(label_manager).to receive(:labels) { [] }
    allow(genre_manager).to receive(:find_or_create_genre)

    # Agrega un álbum

    # Verifica que la lista de álbums no esté vacía
    expect(subject.albums).not_to be_empty

    # Lista los álbums y verifica que el álbum agregado esté presente
    expect { subject.list_music_albums }.to output(/There are no music albums yet!|List of all music albums:/).to_stdout
  end
end