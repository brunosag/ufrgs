import { API_URL } from '$lib/db';
import fs from 'fs';
import type { PageServerLoad } from './$types';

export const load: PageServerLoad = async ({ fetch }) => {
	async function resetDB() {
		await fetch(API_URL);
	}
	async function createView() {
		await fetch(`${API_URL}/api/v1/POST/consultas?query_id=view`, {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({})
		});
	}
	async function createTrigger() {
		const query = fs.readFileSync('src/lib/sql/trigger.sql', 'utf-8');
		await fetch(`${API_URL}/api/v1/POST/query`, {
			method: 'POST',
			headers: { 'Content-Type': 'application/json' },
			body: JSON.stringify({ query, params: {} })
		});
	}
	await resetDB();
	await createView();
	await createTrigger();
};
