-- Consulta 10: Perfil completo de leitura por usuário com estatísticas detalhadas
SELECT u.first_name,
	u.last_name,
	COUNT(DISTINCT t.edition_id) as total_books_read,
	ROUND(AVG(t.rating), 2) as avg_rating,
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
