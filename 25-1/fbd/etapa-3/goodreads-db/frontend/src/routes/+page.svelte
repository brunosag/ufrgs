<script lang="ts">
	import QueriesTab from '$lib/components/QueriesTab.svelte';
	import ResultsDrawer from '$lib/components/ResultsDrawer.svelte';
	import TriggerTab from '$lib/components/TriggerTab.svelte';
	import * as Tabs from '$lib/components/ui/tabs';
	import type { Result } from '$lib/types';

	let result: Result | null = $state(null);
</script>

<div class="my-16 flex flex-col items-center justify-center gap-16 px-6">
	<h1 class="font-mono text-2xl">goodreads-db-viewer</h1>
	<Tabs.Root value="queries" class="w-full max-w-2xl">
		<Tabs.List class="w-full">
			<Tabs.Trigger value="queries">Consultas</Tabs.Trigger>
			<Tabs.Trigger value="trigger">Gatilho</Tabs.Trigger>
		</Tabs.List>
		<Tabs.Content value="queries">
			<QueriesTab bind:result />
		</Tabs.Content>
		<Tabs.Content value="trigger" class="flex flex-col gap-2">
			<TriggerTab bind:result />
		</Tabs.Content>
	</Tabs.Root>
</div>

<ResultsDrawer {result} />
