-- Consulta 1: Livros com alta avaliação e estatísticas de leitura dos usuários
SELECT bd.work_title,
	bd.edition_title,
	bd.author_name,
	bd.genre_label,
	bd.work_rating,
	bd.page_count,
	bd.publisher,
	COUNT(t.edition_id) as total_readings,
	ROUND(AVG(t.rating), 2) as avg_user_rating
FROM book_details bd
	LEFT JOIN trackings t ON bd.edition_id = t.edition_id
	LEFT JOIN users u ON t.user_id = u.id
WHERE bd.work_rating >= (%(rating)s)
GROUP BY bd.work_title,
	bd.edition_title,
	bd.author_name,
	bd.genre_label,
	bd.work_rating,
	bd.page_count,
	bd.publisher
ORDER BY bd.work_rating DESC,
	bd.work_title;