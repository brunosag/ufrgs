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