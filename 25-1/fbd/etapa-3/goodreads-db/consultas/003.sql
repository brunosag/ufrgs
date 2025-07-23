-- Consulta 3: Estatísticas de leitura por gênero com número de leitores e avaliações médias
SELECT g.label as genre,
	COUNT(DISTINCT t.user_id) as total_readers,
	ROUND(AVG(t.rating), 2) as avg_rating,
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