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