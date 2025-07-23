<script lang="ts">
	import * as Drawer from '$lib/components/ui/drawer';
	import * as Table from '$lib/components/ui/table';
	import type { Result } from '$lib/types';

	let { result }: { result: Result | null } = $props();

	let isOpen = $state(false);

	$effect(() => {
		if (result) isOpen = true;
	});
</script>

<Drawer.Root bind:open={isOpen}>
	<Drawer.Content>
		{#if result}
			<Drawer.Header class="text-center">
				<Drawer.Title>{result.title}</Drawer.Title>
				<Drawer.Description>{result.description}</Drawer.Description>
			</Drawer.Header>
			<div class="flex flex-col justify-center overflow-y-auto pt-8 pb-12">
				{#if result.data.length > 0}
					<Table.Root class="mx-auto w-fit">
						<Table.Header>
							<Table.Row>
								{#each Object.keys(result.data[0]) as key}
									<Table.Head class="px-6">{key}</Table.Head>
								{/each}
							</Table.Row>
						</Table.Header>
						<Table.Body>
							{#each result.data as row (row)}
								<Table.Row>
									{#each Object.values(row) as value}
										<Table.Cell class="px-6">{value}</Table.Cell>
									{/each}
								</Table.Row>
							{/each}
						</Table.Body>
					</Table.Root>
				{:else}
					<p class="text-muted-foreground/60 text-center text-sm">Nenhum resultado encontrado</p>
				{/if}
			</div>
		{/if}
	</Drawer.Content>
</Drawer.Root>
