<script lang="ts">
	import { Button } from '$lib/components/ui/button';
	import * as Card from '$lib/components/ui/card';
	import { Input } from '$lib/components/ui/input';
	import { Label } from '$lib/components/ui/label';
	import { runQuery } from '$lib/db';
	import trigger from '$lib/trigger.json';
	import type { Result, TriggerQuery } from '$lib/types';
	import ChevronDownIcon from 'lucide-svelte/icons/chevron-down';
	import { expoOut } from 'svelte/easing';
	import { slide } from 'svelte/transition';

	let {
		query,
		selectedQuery = $bindable(),
		result = $bindable()
	}: { query: TriggerQuery; selectedQuery: TriggerQuery | null; result: Result | null } = $props();

	let isOpen = $derived(selectedQuery?.title === query.title);

	function handleSelect(title: string) {
		selectedQuery =
			title === selectedQuery?.title
				? null
				: (trigger.find((query) => query.title === title) as TriggerQuery);
	}

	async function handleRunQuery(query: string, params?: TriggerQuery['params']) {
		result = {
			title: selectedQuery?.title,
			data: await runQuery(
				query,
				params?.reduce(
					(acc, param) => {
						acc[param.name] = param.value;
						return acc;
					},
					{} as Record<string, string | number>
				)
			)
		};
	}
</script>

<Card.Root class="gap-0 p-0">
	<button onclick={() => handleSelect(query.title)} class="p-6 text-left">
		<Card.Header class="p-0">
			<Card.Title>{query.title}</Card.Title>
			<Card.Action class="flex h-full items-center">
				<ChevronDownIcon
					class="text-muted-foreground size-4 transition-all duration-400 {isOpen
						? 'rotate-180'
						: ''}"
				/>
			</Card.Action>
		</Card.Header>
	</button>
	{#if isOpen}
		<Card.Content>
			<div transition:slide={{ duration: 400, easing: expoOut }} class="grid">
				<div class="flex items-center gap-4 pb-6">
					{#if selectedQuery?.params}
						{#each selectedQuery.params as param}
							<div class="flex items-center gap-2">
								<Label for={param.name}>{param.name}</Label>
								<Input
									type={param.type}
									id={param.name}
									bind:value={param.value}
									class="max-w-32"
								/>
							</div>
						{/each}
					{/if}
					<Button onclick={() => handleRunQuery(query.query, selectedQuery?.params)}>
						Executar
					</Button>
				</div>
			</div>
		</Card.Content>
	{/if}
</Card.Root>
