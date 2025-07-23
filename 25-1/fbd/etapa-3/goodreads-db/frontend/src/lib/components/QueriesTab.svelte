<script lang="ts">
	import queries from '$lib/queries.json';
	import type { Query, Result } from '$lib/types';
	import QueryCard from './QueryCard.svelte';

	let { result = $bindable() }: { result: Result | null } = $props();

	let selectedQuery: Query | null = $state(queries[0]);
</script>

<div class="flex flex-col gap-2">
	{#each queries as query (query.queryId)}
		<QueryCard {query} bind:selectedQuery bind:result />
	{/each}
</div>
