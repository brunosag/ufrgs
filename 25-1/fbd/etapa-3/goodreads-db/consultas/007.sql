-- Consulta 7: Grupos de leitura ativos com livros em andamento e estatísticas de participação
SELECT g.name as group_name,
	g.description as group_description,
	bd.work_title as current_book,
	bd.author_name,
	cr.start_date as reading_start_date,
	COUNT(m.user_id) as total_members,
	COUNT(DISTINCT mod.user_id) as total_moderators,
	ROUND(AVG(t.progress), 2) as avg_member_progress,
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