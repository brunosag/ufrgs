---------------------------------------------------------------
--	Bruno Samuel Ardenghi Gonçalves ― 550452
--	Leonardo Azzi Martins ― 323721
---------------------------------------------------------------

-- Visão: book_details - Contém todas as informações de um livro, combinando detalhes da obra, edições, autores e gêneros.
CREATE VIEW book_details AS
SELECT w.id as work_id,
	w.title as work_title,
	w.first_publication_date,
	w.mean_rating as work_rating,
	e.id as edition_id,
	e.title as edition_title,
	e.page_count,
	e.format,
	e.publication_date,
	e.publisher,
	e.language,
	e.isbn,
	e.cover_image_url,
	e.summary,
	a.id as author_id,
	a.name as author_name,
	a.birth_date as author_birth_date,
	g.id as genre_id,
	g.label as genre_label,
	g.slug as genre_slug
FROM works w
	JOIN editions e ON w.id = e.work_id
	JOIN authorships au ON w.id = au.work_id
	JOIN authors a ON au.author_id = a.id
	LEFT JOIN categorizations c ON w.id = c.work_id
	LEFT JOIN genres g ON c.genre_id = g.id;

-- Consulta 1: Livros com alta avaliação e estatísticas de leitura dos usuários
SELECT bd.work_title,
	bd.edition_title,
	bd.author_name,
	bd.genre_label,
	bd.work_rating,
	bd.page_count,
	bd.publisher,
	COUNT(t.edition_id) as total_readings,
	AVG(t.rating) as avg_user_rating
FROM book_details bd
	LEFT JOIN trackings t ON bd.edition_id = t.edition_id
	LEFT JOIN users u ON t.user_id = u.id
WHERE bd.work_rating >= 4.5
GROUP BY bd.work_title,
	bd.edition_title,
	bd.author_name,
	bd.genre_label,
	bd.work_rating,
	bd.page_count,
	bd.publisher
ORDER BY bd.work_rating DESC,
	bd.work_title;

-- Consulta 2: Usuários que leram livros de todos os gêneros disponíveis (leitores completistas)
SELECT DISTINCT u.first_name,
	u.last_name,
	u.email
FROM users u
WHERE NOT EXISTS (
		SELECT g.id
		FROM genres g
		WHERE NOT EXISTS (
				SELECT 1
				FROM trackings t
					JOIN editions e ON t.edition_id = e.id
					JOIN works w ON e.work_id = w.id
					JOIN categorizations c ON w.id = c.work_id
				WHERE t.user_id = u.id
					AND t.status = 'read'
					AND c.genre_id = g.id
			)
	);

-- Consulta 3: Estatísticas de leitura por gênero com número de leitores e avaliações médias
SELECT g.label as genre,
	COUNT(DISTINCT t.user_id) as total_readers,
	AVG(t.rating) as avg_rating,
	COUNT(*) as total_readings
FROM trackings t
	JOIN editions e ON t.edition_id = e.id
	JOIN works w ON e.work_id = w.id
	JOIN categorizations c ON w.id = c.work_id
	JOIN genres g ON c.genre_id = g.id
WHERE t.status = 'read'
GROUP BY g.id,
	g.label
HAVING COUNT(DISTINCT t.user_id) >= 1
ORDER BY total_readers DESC;

-- Consulta 4: Ranking de autores mais populares baseado em curtidas de suas citações
SELECT a.name as author_name,
	COUNT(l.quote_id) as total_likes,
	COUNT(DISTINCT l.user_id) as unique_likers
FROM authors a
	JOIN quotes q ON a.id = q.author_id
	LEFT JOIN likes l ON q.id = l.quote_id
GROUP BY a.id,
	a.name
ORDER BY total_likes DESC;

-- Consulta 5: Séries literárias com suas obras ordenadas por posição na série
SELECT s.title as series_title,
	bd.work_title,
	bd.author_name,
	p.position,
	bd.work_rating
FROM series s
	JOIN positionings p ON s.id = p.series_id
	JOIN book_details bd ON p.work_id = bd.work_id
ORDER BY s.title,
	p.position;

-- Consulta 6: Usuários que leram mais livros que a média anual (desafio de leitura acima da média)
SELECT u.first_name,
	u.last_name,
	yearly_stats.reading_year,
	yearly_stats.books_read,
	yearly_stats.avg_rating,
	yearly_stats.total_pages
FROM users u
	JOIN (
		SELECT t.user_id,
			EXTRACT(
				YEAR
				FROM UPPER(t.reading_period)
			) as reading_year,
			COUNT(*) as books_read,
			AVG(t.rating) as avg_rating,
			SUM(e.page_count) as total_pages
		FROM trackings t
			JOIN editions e ON t.edition_id = e.id
		WHERE t.status = 'read'
			AND t.reading_period IS NOT NULL
		GROUP BY t.user_id,
			EXTRACT(
				YEAR
				FROM UPPER(t.reading_period)
			)
	) yearly_stats ON u.id = yearly_stats.user_id
WHERE yearly_stats.books_read > (
		SELECT AVG(books_per_user)
		FROM (
				SELECT COUNT(*) as books_per_user
				FROM trackings t2
				WHERE t2.status = 'read'
					AND t2.reading_period IS NOT NULL
					AND EXTRACT(
						YEAR
						FROM UPPER(t2.reading_period)
					) = yearly_stats.reading_year
				GROUP BY t2.user_id
			) as yearly_averages
	)
ORDER BY yearly_stats.reading_year DESC,
	yearly_stats.books_read DESC;

-- Consulta 7: Grupos de leitura ativos com livros em andamento e estatísticas de participação
SELECT g.name as group_name,
	g.description as group_description,
	bd.work_title as current_book,
	bd.author_name,
	cr.start_date as reading_start_date,
	COUNT(m.user_id) as total_members,
	COUNT(DISTINCT mod.user_id) as total_moderators,
	AVG(t.progress) as avg_member_progress,
	COUNT(
		CASE
			WHEN t.status = 'currently-reading' THEN 1
		END
	) as members_reading_same_book
FROM groups g
	JOIN currently_readings cr ON g.id = cr.group_id
	JOIN book_details bd ON cr.edition_id = bd.edition_id
	LEFT JOIN memberships m ON g.id = m.group_id
	LEFT JOIN moderations mod ON g.id = mod.group_id
	LEFT JOIN trackings t ON cr.edition_id = t.edition_id
	AND t.user_id = m.user_id
WHERE cr.finish_date IS NULL
GROUP BY g.id,
	g.name,
	g.description,
	bd.work_title,
	bd.author_name,
	cr.start_date
ORDER BY total_members DESC,
	reading_start_date DESC;

-- Consulta 8: Histórico de leituras recentes dos usuários com avaliações e resenhas
SELECT u.first_name,
	u.last_name,
	bd.work_title as book_title,
	bd.author_name,
	t.rating,
	t.review,
	UPPER(t.reading_period) as finish_date
FROM trackings t
	JOIN users u ON t.user_id = u.id
	JOIN book_details bd ON t.edition_id = bd.edition_id
WHERE t.status = 'read'
	AND t.reading_period IS NOT NULL
ORDER BY UPPER(t.reading_period) DESC;

-- Consulta 9: Análise de preferências de formato de livro pelos usuários
SELECT e.format,
	COUNT(DISTINCT t.user_id) as unique_readers,
	COUNT(*) as total_trackings,
	AVG(t.progress) as avg_progress
FROM trackings t
	JOIN editions e ON t.edition_id = e.id
	JOIN users u ON t.user_id = u.id
GROUP BY e.format
ORDER BY total_trackings DESC;

-- Consulta 10: Perfil completo de leitura por usuário com estatísticas detalhadas
SELECT u.first_name,
	u.last_name,
	COUNT(DISTINCT t.edition_id) as total_books_read,
	AVG(t.rating) as avg_rating,
	SUM(e.page_count) as total_pages_read,
	COUNT(DISTINCT g.id) as genres_explored,
	MAX(UPPER(t.reading_period)) as last_book_finished,
	COUNT(
		CASE
			WHEN t.status = 'currently-reading' THEN 1
		END
	) as currently_reading
FROM users u
	LEFT JOIN trackings t ON u.id = t.user_id
	LEFT JOIN editions e ON t.edition_id = e.id
	LEFT JOIN works w ON e.work_id = w.id
	LEFT JOIN categorizations c ON w.id = c.work_id
	LEFT JOIN genres g ON c.genre_id = g.id
WHERE t.status IN ('read', 'currently-reading')
GROUP BY u.id,
	u.first_name,
	u.last_name
HAVING COUNT(DISTINCT t.edition_id) >= 1
ORDER BY total_books_read DESC;
