-- Escreva o código SQL que permite criar as relações (movies, movie_genre, genre) definidas no modelo 1 do enunciado do projeto, incluindo as respetivas restrições de integridade referencial definidas no esquema físico:


CREATE TABLE genre (
	id_genre DECIMAL(4,0),
	name VARCHAR(50),
	PRIMARY KEY(id_genre)
);


CREATE TABLE movies (
	id_movie DECIMAL(6,0),
	name VARCHAR(250),
	length DECIMAL(3,0),
	budget DECIMAL(9,0),
	date DATETIME,
	PRIMARY KEY(id_movie)
);


CREATE TABLE movie_genre (
	id_genre DECIMAL(4,0),
	id_movie DECIMAL(6,0),
	PRIMARY KEY(id_movie, id_genre),
	CONSTRAINT fk_movie_genre_genre FOREIGN KEY (id_genre) REFERENCES genre(id_genre),
	CONSTRAINT fk_movie_genre_movie FOREIGN KEY (id_movie) REFERENCES movies(id_movie)
);

