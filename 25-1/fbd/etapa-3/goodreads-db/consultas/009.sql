-- Consulta 9: Análise de preferências de formato de livro pelos usuários
SELECT e.format,
	COUNT(DISTINCT t.user_id) as unique_readers,
	COUNT(*) as total_trackings,
	ROUND(AVG(t.progress), 2) as avg_progress
FROM trackings t
	JOIN editions e ON t.edition_id = e.id
	JOIN users u ON t.user_id = u.id
GROUP BY e.format
ORDER BY total_trackings DESC;