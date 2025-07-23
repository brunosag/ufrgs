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