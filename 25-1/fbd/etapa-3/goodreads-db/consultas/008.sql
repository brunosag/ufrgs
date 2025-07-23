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