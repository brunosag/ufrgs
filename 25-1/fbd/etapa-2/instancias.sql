---------------------------------------------------------------
--	Bruno Samuel Ardenghi Gonçalves ― 550452
--	Leonardo Azzi Martins ― 323721
---------------------------------------------------------------

DELETE FROM likes;
DELETE FROM trackings;
DELETE FROM storages;
DELETE FROM ownerships;
DELETE FROM memberships;
DELETE FROM moderations;
DELETE FROM currently_readings;
DELETE FROM votes;
DELETE FROM list_entries;
DELETE FROM categorizations;
DELETE FROM authorships;
DELETE FROM positionings;
DELETE FROM quotes;
DELETE FROM shelves;
DELETE FROM lists;
DELETE FROM groups;
DELETE FROM editions;
DELETE FROM works;
DELETE FROM series;
DELETE FROM authors;
DELETE FROM genres;
DELETE FROM users;

INSERT INTO genres (id, slug, label, description) VALUES
    (1, 'fantasy', 'Fantasy', 'Livros de fantasia e magia'),
    (2, 'sci-fi', 'Science Fiction', 'Ficção científica'),
    (3, 'mystery', 'Mystery', 'Livros de mistério e suspense'),
    (4, 'romance', 'Romance', 'Romances e histórias de amor'),
    (5, 'non-fiction', 'Non-Fiction', 'Livros não-ficcionais');

INSERT INTO authors (id, name, picture_url, birth_place, birth_date, death_date, website, biography) VALUES
    (1, 'J.R.R. Tolkien', 'https://example.com/tolkien.jpg', 'Bloemfontein', '1892-01-03', '1973-09-02', 'https://tolkienestate.com', 'Autor de O Senhor dos Anéis'),
    (2, 'George R.R. Martin', 'https://example.com/martin.jpg', 'Bayonne', '1948-09-20', NULL, 'https://georgerrmartin.com', 'Autor de As Crônicas de Gelo e Fogo'),
    (3, 'Agatha Christie', 'https://example.com/christie.jpg', 'Torquay', '1890-09-15', '1976-01-12', NULL, 'Rainha do crime'),
    (4, 'Jane Austen', 'https://example.com/austen.jpg', 'Steventon', '1775-12-16', '1817-07-18', NULL, 'Autora clássica de romances'),
    (5, 'Isaac Asimov', 'https://example.com/asimov.jpg', 'Petrovichi', '1920-01-02', '1992-04-06', NULL, 'Mestre da ficção científica'),
    (6, 'Stephen Hawking', 'https://example.com/hawking.jpg', 'Oxford', '1942-01-08', '2018-03-14', NULL, 'Físico teórico e cosmólogo');

INSERT INTO series (id, title) VALUES
    (1, 'O Senhor dos Anéis'),
    (2, 'As Crônicas de Gelo e Fogo'),
    (3, 'Fundação');

INSERT INTO works (id, title, first_publication_date, mean_rating) VALUES
    (1, 'O Hobbit', '1937-09-21', 4.5),
    (2, 'O Senhor dos Anéis: A Sociedade do Anel', '1954-07-29', 4.8),
    (3, 'O Senhor dos Anéis: As Duas Torres', '1954-11-11', 4.7),
    (4, 'O Senhor dos Anéis: O Retorno do Rei', '1955-10-20', 4.9),
    (5, 'A Guerra dos Tronos', '1996-08-01', 4.6),
    (6, 'A Fúria dos Reis', '1998-11-16', 4.5),
    (7, 'A Tormenta de Espadas', '2000-08-08', 4.7),
    (8, 'Assassinato no Expresso do Oriente', '1934-01-01', 4.3),
    (9, 'Orgulho e Preconceito', '1813-01-28', 4.4),
    (10, 'Fundação', '1951-05-01', 4.6),
    (11, 'Fundação e Império', '1952-06-01', 4.5),
    (12, 'Segunda Fundação', '1953-01-01', 4.7),
    (13, 'Breve História do Tempo', '1988-04-01', 4.2);

INSERT INTO editions (id, title, page_count, format, publication_date, publisher, language, cover_image_url, summary, isbn, asin, work_id) VALUES
    (1, 'O Hobbit - Edição Ilustrada', 366, 'Hardcover', '2012-09-27', 'HarperCollins', 'Portuguese', 'https://example.com/hobbit.jpg', 'A história de Bilbo Bolseiro', '9780007487301', 'B008HZ6KXG', 1),
    (2, 'O Hobbit - Edição de Bolso', 366, 'Paperback', '2013-03-14', 'HarperCollins', 'Portuguese', 'https://example.com/hobbit-pb.jpg', 'A história de Bilbo Bolseiro', '9780007487318', 'B008HZ6KXH', 1),
    (3, 'A Sociedade do Anel', 576, 'Hardcover', '2014-06-19', 'HarperCollins', 'Portuguese', 'https://example.com/fellowship.jpg', 'Primeiro volume da trilogia', '9780007487325', 'B008HZ6KXI', 2),
    (4, 'As Duas Torres', 464, 'Ebook', '2014-07-17', 'HarperCollins', 'Portuguese', 'https://example.com/towers.jpg', 'Segundo volume da trilogia', '9780007487332', 'B008HZ6KXJ', 3),
    (5, 'O Retorno do Rei', 496, 'Hardcover', '2014-08-14', 'HarperCollins', 'Portuguese', 'https://example.com/return.jpg', 'Terceiro volume da trilogia', '9780007487349', 'B008HZ6KXK', 4),
    (6, 'A Guerra dos Tronos', 694, 'Hardcover', '2011-07-12', 'Bantam Books', 'English', 'https://example.com/got.jpg', 'Primeiro livro da série', '9780553103540', 'B004JN1D40', 5),
    (7, 'A Fúria dos Reis', 768, 'Audiobook', '2011-10-31', 'Bantam Books', 'English', 'https://example.com/cok.jpg', 'Segundo livro da série', '9780553108033', 'B004JN1D41', 6),
    (8, 'A Tormenta de Espadas', 992, 'Mass Market Paperback', '2011-10-31', 'Bantam Books', 'English', 'https://example.com/sos.jpg', 'Terceiro livro da série', '9780553106633', 'B004JN1D42', 7),
    (9, 'Assassinato no Expresso do Oriente', 256, 'Paperback', '2017-01-01', 'HarperCollins', 'Portuguese', 'https://example.com/orient.jpg', 'Um dos mais famosos casos de Poirot', '9780008196526', 'B01N5IB20Q', 8),
    (10, 'Orgulho e Preconceito', 432, 'Hardcover', '2014-01-01', 'Penguin Classics', 'English', 'https://example.com/pride.jpg', 'Clássico romance de Jane Austen', '9780141439518', 'B00F8J5IDQ', 9),
    (11, 'Fundação', 255, 'Paperback', '2004-06-01', 'Spectra', 'English', 'https://example.com/foundation.jpg', 'Primeiro livro da série Fundação', '9780553293357', 'B000FC0SXA', 10),
    (12, 'Fundação e Império', 247, 'Ebook', '2004-06-01', 'Spectra', 'English', 'https://example.com/foundation-empire.jpg', 'Segundo livro da série Fundação', '9780553293371', 'B000FC0SXB', 11),
    (13, 'Segunda Fundação', 256, 'Mass Market Paperback', '2004-06-01', 'Spectra', 'English', 'https://example.com/second-foundation.jpg', 'Terceiro livro da série Fundação', '9780553293364', 'B000FC0SXC', 12),
    (14, 'Breve História do Tempo', 256, 'Audiobook', '1988-04-01', 'Bantam Books', 'English', 'https://example.com/brief-history.jpg', 'Do Big Bang aos Buracos Negros', '9780553053404', 'B000FC0SXD', 13);

INSERT INTO users (id, email, password, first_name, last_name, picture_url) VALUES
    (1, 'joao.silva@email.com', 'senha123', 'João', 'Silva', 'https://example.com/joao.jpg'),
    (2, 'maria.santos@email.com', 'senha456', 'Maria', 'Santos', 'https://example.com/maria.jpg'),
    (3, 'pedro.oliveira@email.com', 'senha789', 'Pedro', 'Oliveira', 'https://example.com/pedro.jpg'),
    (4, 'ana.costa@email.com', 'senha101', 'Ana', 'Costa', 'https://example.com/ana.jpg'),
    (5, 'carlos.rodrigues@email.com', 'senha202', 'Carlos', 'Rodrigues', 'https://example.com/carlos.jpg'),
    (6, 'lucia.ferreira@email.com', 'senha303', 'Lúcia', 'Ferreira', 'https://example.com/lucia.jpg'),
    (7, 'roberto.almeida@email.com', 'senha404', 'Roberto', 'Almeida', 'https://example.com/roberto.jpg'),
    (8, 'julia.martins@email.com', 'senha505', 'Julia', 'Martins', 'https://example.com/julia.jpg');

INSERT INTO groups (id, name, description, picture_url) VALUES
    (1, 'Clube de Leitura Fantasia', 'Grupo dedicado à leitura de fantasia', 'https://example.com/fantasy-club.jpg'),
    (2, 'Leitores de Mistério', 'Fãs de livros de mistério e suspense', 'https://example.com/mystery-readers.jpg'),
    (3, 'Clube de Ficção Científica', 'Discussões sobre sci-fi', 'https://example.com/scifi-club.jpg');

INSERT INTO lists (id, title, description) VALUES
    (1, 'Melhores Livros de Fantasia', 'Os melhores livros de fantasia de todos os tempos'),
    (2, 'Clássicos da Literatura', 'Livros clássicos que todos devem ler'),
    (3, 'Mistérios Imperdíveis', 'Os melhores livros de mistério');

INSERT INTO shelves (id, slug) VALUES
    (1, 'favoritos'),
    (2, 'para-ler'),
    (3, 'lidos-2024'),
    (4, 'lidos-2025'),
    (5, 'colecao-tolkien'),
    (6, 'colecao-martin');

INSERT INTO quotes (id, quote, author_id) VALUES
    (1, 'Um anel para governar a todos, um anel para encontrá-los, um anel para trazê-los todos e na escuridão aprisioná-los.', 1),
    (2, 'Quando você joga o jogo dos tronos, você vence ou morre.', 2),
    (3, 'É uma verdade universalmente reconhecida que um homem solteiro em posse de uma boa fortuna deve estar necessitando de uma esposa.', 4),
    (4, 'A violência é o último refúgio do incompetente.', 5),
    (5, 'O medo é a morte da razão.', 2),
    (6, 'Não é sábio ser muito certo da própria sabedoria.', 1);

INSERT INTO positionings (series_id, work_id, position) VALUES
    (1, 2, 1),  -- O Senhor dos Anéis: A Sociedade do Anel
    (1, 3, 2),  -- O Senhor dos Anéis: As Duas Torres
    (1, 4, 3),  -- O Senhor dos Anéis: O Retorno do Rei
    (2, 5, 1),  -- As Crônicas de Gelo e Fogo: A Guerra dos Tronos
    (2, 6, 2),  -- As Crônicas de Gelo e Fogo: A Fúria dos Reis
    (2, 7, 3),  -- As Crônicas de Gelo e Fogo: A Tormenta de Espadas
    (3, 10, 1), -- Fundação: Fundação
    (3, 11, 2), -- Fundação: Fundação e Império
    (3, 12, 3); -- Fundação: Segunda Fundação

INSERT INTO categorizations (work_id, genre_id) VALUES
    (1, 1),   -- O Hobbit - Fantasy
    (2, 1),   -- A Sociedade do Anel - Fantasy
    (3, 1),   -- As Duas Torres - Fantasy
    (4, 1),   -- O Retorno do Rei - Fantasy
    (5, 1),   -- A Guerra dos Tronos - Fantasy
    (6, 1),   -- A Fúria dos Reis - Fantasy
    (7, 1),   -- A Tormenta de Espadas - Fantasy
    (8, 3),   -- Assassinato no Expresso do Oriente - Mystery
    (9, 4),   -- Orgulho e Preconceito - Romance
    (10, 2),  -- Fundação - Sci-Fi
    (11, 2),  -- Fundação e Império - Sci-Fi
    (12, 2),  -- Segunda Fundação - Sci-Fi
    (13, 5);  -- Breve História do Tempo - Non-Fiction

INSERT INTO authorships (work_id, author_id) VALUES
    (1, 1),   -- O Hobbit - Tolkien
    (2, 1),   -- A Sociedade do Anel - Tolkien
    (3, 1),   -- As Duas Torres - Tolkien
    (4, 1),   -- O Retorno do Rei - Tolkien
    (5, 2),   -- A Guerra dos Tronos - Martin
    (6, 2),   -- A Fúria dos Reis - Martin
    (7, 2),   -- A Tormenta de Espadas - Martin
    (8, 3),   -- Assassinato no Expresso do Oriente - Christie
    (9, 4),   -- Orgulho e Preconceito - Austen
    (10, 5),  -- Fundação - Asimov
    (11, 5),  -- Fundação e Império - Asimov
    (12, 5),  -- Segunda Fundação - Asimov
    (13, 6);  -- Breve História do Tempo - Hawking

INSERT INTO storages (edition_id, shelf_id) VALUES
    (1, 5),   -- O Hobbit na coleção Tolkien
    (3, 5),   -- A Sociedade do Anel na coleção Tolkien
    (4, 5),   -- As Duas Torres na coleção Tolkien
    (5, 5),   -- O Retorno do Rei na coleção Tolkien
    (6, 6),   -- A Guerra dos Tronos na coleção Martin
    (7, 6),   -- A Fúria dos Reis na coleção Martin
    (8, 6),   -- A Tormenta de Espadas na coleção Martin
    (10, 1),  -- Orgulho e Preconceito nos favoritos
    (11, 3),  -- Fundação nos lidos 2024
    (12, 3),  -- Fundação e Império nos lidos 2024
    (13, 4),  -- Segunda Fundação nos lidos 2025
    (14, 3);  -- Breve História do Tempo nos lidos 2024

INSERT INTO ownerships (shelf_id, user_id) VALUES
    (1, 1),   -- João possui estante favoritos
    (2, 1),   -- João possui estante para-ler
    (3, 2),   -- Maria possui estante lidos-2024
    (4, 2),   -- Maria possui estante lidos-2025
    (5, 3),   -- Pedro possui coleção Tolkien
    (6, 4),   -- Ana possui coleção Martin
    (1, 5),   -- Carlos possui estante favoritos
    (2, 6),   -- Lúcia possui estante para-ler
    (3, 7),   -- Roberto possui estante lidos-2024
    (4, 8);   -- Julia possui estante lidos-2025

INSERT INTO trackings (edition_id, user_id, status, progress, rating, review, reading_period) VALUES
    -- João Silva - leu livros de todos os gêneros
    (1, 1, 'read', 100, 5, 'Excelente livro!', '[2024-01-15,2024-02-15)'),
    (9, 1, 'read', 100, 4, 'Clássico atemporal', '[2024-03-01,2024-04-01)'),
    (11, 1, 'read', 100, 5, 'Obra-prima da ficção científica', '[2024-05-01,2024-06-01)'),
    (8, 1, 'read', 100, 4, 'Mistério envolvente', '[2024-07-01,2024-08-01)'),
    (10, 1, 'read', 100, 4, 'Romance clássico', '[2024-09-01,2024-10-01)'),
    (14, 1, 'read', 100, 4, 'Fascinante explicação do universo', '[2024-11-01,2024-12-01)'),
    
    -- Maria Santos - leu muitos livros em 2024
    (1, 2, 'read', 100, 5, 'Adorei!', '[2024-01-01,2024-01-31)'),
    (2, 2, 'read', 100, 5, 'Fantástico!', '[2024-02-01,2024-03-15)'),
    (3, 2, 'read', 100, 4, 'Muito bom', '[2024-04-01,2024-05-15)'),
    (4, 2, 'read', 100, 5, 'Perfeito!', '[2024-06-01,2024-07-15)'),
    (5, 2, 'read', 100, 4, 'Interessante', '[2024-08-01,2024-09-15)'),
    (6, 2, 'read', 100, 4, 'Bom desenvolvimento', '[2024-10-01,2024-11-15)'),
    (7, 2, 'read', 100, 5, 'Excelente!', '[2024-12-01,2024-12-31)'),
    (8, 2, 'read', 100, 4, 'Mistério bem construído', '[2024-01-15,2024-02-15)'),
    (9, 2, 'read', 100, 4, 'Clássico', '[2024-03-01,2024-04-01)'),
    (10, 2, 'read', 100, 5, 'Genial!', '[2024-05-01,2024-06-01)'),
    (11, 2, 'read', 100, 4, 'Continuação boa', '[2024-07-01,2024-08-01)'),
    (12, 2, 'read', 100, 5, 'Final perfeito', '[2024-09-01,2024-10-01)'),
    (13, 2, 'read', 100, 4, 'Satisfatório', '[2024-11-01,2024-12-01)'),
    
    -- Pedro Oliveira - leu livros de fantasia
    (1, 3, 'read', 100, 5, 'Obra-prima', '[2024-01-01,2024-02-01)'),
    (2, 3, 'read', 100, 5, 'Fantástico!', '[2024-03-01,2024-04-15)'),
    (3, 3, 'read', 100, 5, 'Excelente continuação', '[2024-05-01,2024-06-15)'),
    (4, 3, 'read', 100, 5, 'Final perfeito', '[2024-07-01,2024-08-15)'),
    (5, 3, 'read', 100, 4, 'Muito bom', '[2024-09-01,2024-10-15)'),
    (6, 3, 'read', 100, 4, 'Boa continuação', '[2024-11-01,2024-12-15)'),
    (7, 3, 'read', 100, 5, 'Melhor da série', '[2025-01-01,2025-02-15)'),
    
    -- Ana Costa - leu livros de ficção científica
    (10, 4, 'read', 100, 5, 'Revolucionário', '[2024-01-01,2024-02-01)'),
    (11, 4, 'read', 100, 5, 'Excelente continuação', '[2024-03-01,2024-04-01)'),
    (12, 4, 'read', 100, 5, 'Final brilhante', '[2024-05-01,2024-06-01)'),
    (13, 4, 'read', 100, 4, 'Muito bom', '[2024-07-01,2024-08-01)'),
    
    -- Carlos Rodrigues - leu livros de mistério
    (8, 5, 'read', 100, 4, 'Mistério envolvente', '[2024-01-01,2024-02-01)'),
    (9, 5, 'read', 100, 4, 'Clássico', '[2024-03-01,2024-04-01)'),
    
    -- Lúcia Ferreira - leu livros de romance
    (9, 6, 'read', 100, 5, 'Romance perfeito', '[2024-01-01,2024-02-01)'),
    (10, 6, 'read', 100, 4, 'Interessante', '[2024-03-01,2024-04-01)'),
    
    -- Roberto Almeida - leu livros de não-ficção
    (14, 7, 'read', 100, 4, 'Informativo', '[2024-01-01,2024-02-01)'),
    
    -- Julia Martins - leu livros de fantasia
    (1, 8, 'read', 100, 5, 'Adorei!', '[2024-01-01,2024-02-01)'),
    (2, 8, 'read', 100, 5, 'Fantástico!', '[2024-03-01,2024-04-01)'),
    (3, 8, 'read', 100, 5, 'Excelente!', '[2024-05-01,2024-06-01)'),
    
    -- Leituras recentes
    (7, 4, 'read', 100, 5, 'Excelente!', '[2025-01-01,2025-01-31)'),
    (8, 6, 'read', 100, 4, 'Bom mistério', '[2025-01-15,2025-02-15)'),
    (11, 6, 'read', 100, 4, 'Clássico', '[2025-02-01,2025-03-01)');

INSERT INTO likes (quote_id, user_id) VALUES
    (1, 1),   -- João curtiu citação do Tolkien
    (1, 2),   -- Maria curtiu citação do Tolkien
    (1, 3),   -- Pedro curtiu citação do Tolkien
    (2, 1),   -- João curtiu citação do Martin
    (2, 4),   -- Ana curtiu citação do Martin
    (2, 5),   -- Carlos curtiu citação do Martin
    (3, 2),   -- Maria curtiu citação da Austen
    (3, 6),   -- Lúcia curtiu citação da Austen
    (4, 3),   -- Pedro curtiu citação do Asimov
    (4, 7),   -- Roberto curtiu citação do Asimov
    (5, 1),   -- João curtiu citação do Martin
    (5, 8),   -- Julia curtiu citação do Martin
    (6, 2),   -- Maria curtiu citação do Tolkien
    (6, 4);   -- Ana curtiu citação do Tolkien

INSERT INTO memberships (user_id, group_id) VALUES
    (1, 1),   -- João no Clube de Fantasia
    (2, 1),   -- Maria no Clube de Fantasia
    (3, 1),   -- Pedro no Clube de Fantasia
    (4, 2),   -- Ana no Clube de Mistério
    (5, 2),   -- Carlos no Clube de Mistério
    (6, 2),   -- Lúcia no Clube de Mistério
    (7, 3),   -- Roberto no Clube de Sci-Fi
    (8, 3);   -- Julia no Clube de Sci-Fi

INSERT INTO moderations (user_id, group_id) VALUES
    (1, 1),   -- João modera Clube de Fantasia
    (4, 2),   -- Ana modera Clube de Mistério
    (7, 3);   -- Roberto modera Clube de Sci-Fi

INSERT INTO currently_readings (edition_id, group_id, start_date, finish_date) VALUES
    (2, 1, '2025-01-01', NULL),    -- Clube de Fantasia lendo O Hobbit (edição paperback)
    (9, 2, '2025-01-15', NULL),    -- Clube de Mistério lendo Orgulho e Preconceito
    (11, 3, '2025-02-01', NULL);   -- Clube de Sci-Fi lendo Fundação e Império

INSERT INTO list_entries (id, vote_count, list_id, edition_id) VALUES
    (1, 5, 1, 1),   -- O Hobbit na lista de fantasia
    (2, 3, 1, 2),   -- A Sociedade do Anel na lista de fantasia
    (3, 4, 1, 5),   -- A Guerra dos Tronos na lista de fantasia
    (4, 2, 2, 9),   -- Orgulho e Preconceito na lista de clássicos
    (5, 3, 2, 10),  -- Fundação na lista de clássicos
    (6, 4, 3, 8);   -- Assassinato no Expresso do Oriente na lista de mistérios

INSERT INTO votes (user_id, list_entry_id) VALUES
    (1, 1),   -- João votou em O Hobbit
    (2, 1),   -- Maria votou em O Hobbit
    (3, 1),   -- Pedro votou em O Hobbit
    (4, 1),   -- Ana votou em O Hobbit
    (5, 1),   -- Carlos votou em O Hobbit
    (1, 2),   -- João votou em A Sociedade do Anel
    (2, 2),   -- Maria votou em A Sociedade do Anel
    (3, 2),   -- Pedro votou em A Sociedade do Anel
    (1, 3),   -- João votou em A Guerra dos Tronos
    (4, 3),   -- Ana votou em A Guerra dos Tronos
    (5, 3),   -- Carlos votou em A Guerra dos Tronos
    (6, 3),   -- Lúcia votou em A Guerra dos Tronos
    (2, 4),   -- Maria votou em Orgulho e Preconceito
    (6, 4),   -- Lúcia votou em Orgulho e Preconceito
    (2, 5),   -- Maria votou em Fundação
    (7, 5),   -- Roberto votou em Fundação
    (8, 5),   -- Julia votou em Fundação
    (4, 6),   -- Ana votou em Assassinato no Expresso do Oriente
    (5, 6),   -- Carlos votou em Assassinato no Expresso do Oriente
    (6, 6),   -- Lúcia votou em Assassinato no Expresso do Oriente
    (7, 6);   -- Roberto votou em Assassinato no Expresso do Oriente
