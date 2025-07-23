<script lang="ts">
	import TriggerCard from '$lib/components/TriggerCard.svelte';
	import trigger from '$lib/trigger.json';
	import type { Result, TriggerQuery } from '$lib/types';

	let { result = $bindable() }: { result: Result | null } = $props();

	let selectedQuery: TriggerQuery | null = $state(trigger[0]);
</script>

<div class="flex flex-col gap-2">
	{#each trigger as query (query.title)}
		<TriggerCard {query} bind:selectedQuery bind:result />
	{/each}
</div>
