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
			ROUND(AVG(t.rating), 2) as avg_rating,
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