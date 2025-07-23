CREATE VIEW book_details AS
SELECT w.id as work_id,
	w.title as work_title,
	w.first_publication_date,
	w.rating as work_rating,
	e.id as edition_id,
	e.title as edition_title,
	e.page_count,
	e.format,
	e.publication_date,
	e.publisher,
	e.language,
	e.isbn,
	e.cover,
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