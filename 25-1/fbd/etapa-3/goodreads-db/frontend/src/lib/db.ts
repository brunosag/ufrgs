export const API_URL = 'http://localhost:5000';

export async function runPreparedQuery(queryId: string, params?: Record<string, string | number>) {
	const response = await fetch(`${API_URL}/api/v1/POST/consultas?query_id=${queryId}`, {
		method: 'POST',
		headers: { 'Content-Type': 'application/json' },
		body: JSON.stringify(params || {})
	});
	return await response.json();
}

export async function runQuery(query: string, params?: Record<string, string | number>) {
	const response = await fetch(`${API_URL}/api/v1/POST/query`, {
		method: 'POST',
		headers: { 'Content-Type': 'application/json' },
		body: JSON.stringify({ query, params: params || {} })
	});
	return await response.json();
}
