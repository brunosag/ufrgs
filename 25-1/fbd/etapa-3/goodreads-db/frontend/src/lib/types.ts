import queries from '$lib/queries.json';
import trigger from '$lib/trigger.json';

export type Result = {
	title?: string;
	description?: string;
	data: Record<string, string | number>[];
};

export type Query = (typeof queries)[number];

export type TriggerQuery = (typeof trigger)[number];
