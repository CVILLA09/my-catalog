CREATE DATABASE catalogs

CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(30),
    last_name VARCHAR(30)
);

CREATE TABLE labels (
    id SERIAL PRIMARY KEY,
    title VARCHAR(30),
    color VARCHAR(30),
);

CREATE TABLE genres (
    id SERIAL PRIMARY KEY,
    name VARCHAR(30)
);

CREATE TABLE items (
    id SERIAL PRIMARY KEY,
    published_date DATE NOT NULL,
    archived BOOLEAN NOT NULL,
    genre_id INT,
    author_id INT,
    label_id INT,
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    FOREIGN KEY (author_id) REFERENCES authors(id),
    FOREIGN KEY (label_id) REFERENCES labels(id) 
);

CREATE TABLE Books(
  id SERIAL PRIMARY KEY,
  genre_id INT,
  author_id INT,
  label_id INT,
  published_date DATE,
  archived BOOLEAN,
  publisher VARCHAR(50) NOT NULL,
  cover_state VARCHAR(20) NOT NULL,
  FOREIGN KEY(genre_id) REFERENCES genres(id),
  FOREIGN KEY(author_id) REFERENCES authors(id),
  FOREIGN KEY(label_id) REFERENCES labels(id)
);

CREATE TABLE music_albums (
    id SERIAL PRIMARY KEY,
    on_spotify BOOLEAN NOT NULL,
    label_id INT,
    genre_id INT,
    author_id INT,
    published_date DATE,
    archived BOOLEAN,
    FOREIGN KEY (label_id) REFERENCES labels(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    FOREIGN KEY (author_id) REFERENCES authors(id) 
);

CREATE TABLE games (
    id SERIAL PRIMARY KEY,
    multiplayer VARCHAR(30) NOT NULL,
    last_played_at DATE NOT NULL,
    label_id INT,
    genre_id INT,
    author_id INT,
    published_date DATE,
    archived BOOLEAN,
    FOREIGN KEY (label_id) REFERENCES labels(id),
    FOREIGN KEY (genre_id) REFERENCES genres(id),
    FOREIGN KEY (author_id) REFERENCES authors(id) 
);