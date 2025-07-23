---------------------------------------------------------------
--	Bruno Samuel Ardenghi Gonçalves ― 550452
--	Leonardo Azzi Martins ― 323721
---------------------------------------------------------------

-- Series (Entidade)
-- Uma série de livros contendo uma ou mais obras primárias explicitamente ordenadas e, opcionalmente, outras obras sem uma posição específica dentro da série.
CREATE TABLE series (
	id SERIAL PRIMARY KEY,
	title VARCHAR(100) NOT NULL
);

-- Work (Entidade)
-- Uma obra literária que engloba todas as suas edições.
CREATE TABLE works (
	id SERIAL PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	first_publication_date DATE NOT NULL,
	rating NUMERIC(2) CHECK (
		rating BETWEEN 1 AND 5
	)
);

-- Genre (Entidade)
-- Um gênero ou categoria de livros. É definido pelo seu nome e usado para agrupar obras com características similares.
CREATE TABLE genres (
	id SERIAL PRIMARY KEY,
	slug VARCHAR(50) NOT NULL UNIQUE,
	label VARCHAR(50) NOT NULL,
	description VARCHAR(2000)
);

-- Author (Entidade)
-- Um autor com zero ou mais obras atribuídas a si. Usado para agrupar livros escritos pela mesma pessoa e fornecer informações sobre estas através de um perfil. Pode ser definido antes de suas obras.
CREATE TABLE authors (
	id SERIAL PRIMARY KEY,
	name VARCHAR(150) NOT NULL,
	picture VARCHAR(500),
	birth_place VARCHAR(50),
	birth_date DATE,
	death_date DATE,
	website VARCHAR(500),
	biography VARCHAR(2000)
);

-- Edition (Entidade)
-- Uma edição ou instância de uma obra. Usado na maior parte das listagens para representar uma obra, pois a mesma pode ter diversas variações com diferenças significativas.
--
-- Publication (Relacionamento)
-- Atribui uma edição à obra a qual ela corresponde.
-- - Work: (1, 1) é instância de
-- - Edition: (1, n) possui
CREATE TABLE editions (
	id SERIAL PRIMARY KEY,
	title VARCHAR(150) NOT NULL,
	page_count SMALLINT NOT NULL,
	format VARCHAR(25) NOT NULL,
	publication_date DATE NOT NULL,
	publisher VARCHAR(50) NOT NULL,
	language VARCHAR(50) NOT NULL,
	cover VARCHAR(500),
	summary VARCHAR(2000),
	isbn CHAR(13),
	asin CHAR(10),
	-- Relacionamento Publication
	work_id INTEGER NOT NULL REFERENCES works(id)
);

-- User (Entidade)
-- Um usuário criado quando um cadastro é feito na plataforma com email e senha. Representa também um perfil. É necessário para fazer interações no site.
CREATE TABLE users (
	id SERIAL PRIMARY KEY,
	email VARCHAR(254) NOT NULL UNIQUE,
	password VARCHAR(35) NOT NULL,
	first_name VARCHAR(50) NOT NULL,
	last_name VARCHAR(50),
	picture VARCHAR(500)
);

-- Group (Entidade)
-- Um grupo criado e composto por usuários, que podem ser moderadores ou membros. Moderadores podem atribuir um ou mais livros como a leitura do grupo durante um período de tempo especificado.
CREATE TABLE groups (
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL,
	description VARCHAR(1000),
	picture VARCHAR(500)
);

-- List (Entidade)
-- Uma lista de livros pública criada por um usuário mas sem atribuição ao mesmo. Qualquer usuário pode adicionar livros à lista, assim como votar em obras já listadas.
CREATE TABLE lists (
	id SERIAL PRIMARY KEY,
	title VARCHAR(100) NOT NULL,
	description VARCHAR(1000)
);

-- ListEntry (Entidade)
-- Uma listagem de um livro em uma lista. Representa uma obra específica dentro de uma lista, podendo conter informações adicionais como a posição na lista e a data de adição.
--
-- Entry (Relacionamento)
-- Atribui uma listagem de um livro à lista na qual ela foi feita.
-- - ListEntry: (0, n) possui
-- - List: (1, 1) faz parte de
CREATE TABLE list_entries (
	id SERIAL PRIMARY KEY,
	vote_count INTEGER NOT NULL CHECK (vote_count >= 0),
	-- Relacionamento Entry
	list_id INTEGER NOT NULL REFERENCES lists(id),
	edition_id INTEGER NOT NULL REFERENCES editions(id)
);

-- Shelf (Entidade)
-- Uma estante ou coleção de livros públicas de um usuário. Não inclui as prateleiras "to-read", "currently-reading" e "read" presentes na plataforma original, as mesmas foram convertidas no relacionamento Tracking.
CREATE TABLE shelves (
	id SERIAL PRIMARY KEY,
	slug VARCHAR(50) NOT NULL UNIQUE
);

-- Quote (Entidade)
-- Uma citação. Frase ou texto atribuída a um autor por um usuário. Pode ser "curtida" por outros usuários.
--
-- Attribution (Relacionamento)
-- Atribui a autoria de uma citação a um autor.
-- - Author: (1, 1) é atribuído a
-- - Quote: (0, n) é dono de
CREATE TABLE quotes (
	id SERIAL PRIMARY KEY,
	quote VARCHAR(500) NOT NULL,
	-- Relacionamento Attribution
	author_id INTEGER NOT NULL REFERENCES authors(id)
);

-- Positioning (Relacionamento)
-- Atribui uma obra a uma série, com ou sem uma posição específica em relação às outras obras da série.
-- - Series: (1, n) contém
-- - Work: (0, n) faz parte de
CREATE TABLE positionings (
	series_id INTEGER NOT NULL REFERENCES series(id),
	work_id INTEGER NOT NULL REFERENCES works(id),
	position NUMERIC(2),
	PRIMARY KEY (series_id, work_id)
);

-- Categorization (Relacionamento)
-- Atribui uma obra a uma categoria ou gênero de livros.
-- - Work: (0, n) categoriza
-- - Genre: (0, n) é categorizado como
CREATE TABLE categorizations (
	work_id INTEGER NOT NULL REFERENCES works(id),
	genre_id INTEGER NOT NULL REFERENCES genres(id),
	PRIMARY KEY (work_id, genre_id)
);

-- Authorship (Relacionamento)
-- Atribui uma obra aos autores que a escreveram.
-- - Work: (0, n) escreveu
-- - Author: (1, n) foi escrito por
CREATE TABLE authorships (
	work_id INTEGER NOT NULL REFERENCES works(id),
	author_id INTEGER NOT NULL REFERENCES authors(id),
	PRIMARY KEY (work_id, author_id)
);

-- Storage (Relacionamento)
-- Atribui uma edição de um livro a uma estante de um usuário.
-- - Edition: (0, n) contém
-- - Shelf: (0, n) está contido em
CREATE TABLE storages (
	edition_id INTEGER NOT NULL REFERENCES editions(id),
	shelf_id INTEGER NOT NULL REFERENCES shelves(id),
	PRIMARY KEY (edition_id, shelf_id)
);

-- Ownership (Relacionamento)
-- Atribui uma estante ao usuário ao qual ela pertence.
-- - Shelf: (0, n) possui
-- - User: (1, 1) pertence a
CREATE TABLE ownerships (
	shelf_id INTEGER NOT NULL REFERENCES shelves(id),
	user_id INTEGER NOT NULL REFERENCES users(id),
	PRIMARY KEY (shelf_id, user_id)
);

-- TrackingStatus (Tipo)
-- Status de rastreamento de um usuário em relação à leitura de um livro.
CREATE TYPE tracking_status AS ENUM ('to-read', 'currently-reading', 'read');

-- Tracking (Relacionamento)
-- Guarda o status e progresso atual de um usuário em relação à leitura de um livro. Pode conter mais de uma leitura e, também, uma avaliação.
-- - Edition: (0, n) rastreia
-- - User: (0, n) é rastreado por
CREATE TABLE trackings (
	edition_id INTEGER NOT NULL REFERENCES editions(id),
	user_id INTEGER NOT NULL REFERENCES users(id),
	status tracking_status NOT NULL,
	progress SMALLINT DEFAULT 0,
	review VARCHAR(18800),
	reading_period DATERANGE,
	rating SMALLINT CHECK (
		rating BETWEEN 1 AND 5
	),
	PRIMARY KEY (edition_id, user_id)
);

-- Like (Relacionamento)
-- Ligação criada quando um usuário curte uma citação.
-- - Quote: (0, n) curtiu
-- - User: (0, n) foi curtido por
CREATE TABLE likes (
	quote_id INTEGER NOT NULL REFERENCES quotes(id),
	user_id INTEGER NOT NULL REFERENCES users(id),
	PRIMARY KEY (quote_id, user_id)
);

-- Membership (Relacionamento)
-- Atribui um usuário a um grupo do qual ele faz parte.
-- - User: (1, n) tem como membro
-- - Group: (0, n) é membro de
CREATE TABLE memberships (
	user_id INTEGER NOT NULL REFERENCES users(id),
	group_id INTEGER NOT NULL REFERENCES groups(id),
	PRIMARY KEY (user_id, group_id)
);

-- Moderation (Relacionamento)
-- Atribui a posição de moderador de um grupo a um usuário. Pode ou não ser um membro do grupo.
-- - User: (1, n) é moderado por
-- - Group: (0, n) modera
CREATE TABLE moderations (
	user_id INTEGER NOT NULL REFERENCES users(id),
	group_id INTEGER NOT NULL REFERENCES groups(id),
	PRIMARY KEY (user_id, group_id)
);

-- CurrentlyReading (Relacionamento)
-- Atribui um livro (edição) a um grupo, representando as leituras atuais deste grupo. Pode incluir uma data de início e de fim.
-- - Edition: (0, n) está lendo
-- - Group: (0, n) está sendo lido por
CREATE TABLE currently_readings (
	edition_id INTEGER NOT NULL REFERENCES editions(id),
	group_id INTEGER NOT NULL REFERENCES groups(id),
	start_date DATE,
	finish_date DATE,
	PRIMARY KEY (edition_id, group_id)
);

-- Vote (Relacionamento)
-- Ligação criada quando um usuário vota em um livro em uma lista.
-- - ListEntry: (0, n) votou em
-- - User: (0, n) foi votado por
CREATE TABLE votes (
	user_id INTEGER NOT NULL REFERENCES users(id),
	list_entry_id INTEGER NOT NULL REFERENCES list_entries(id),
	PRIMARY KEY (user_id, list_entry_id)
);
