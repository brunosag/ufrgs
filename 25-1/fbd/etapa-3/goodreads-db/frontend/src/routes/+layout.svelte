<script lang="ts">
	import ModeToggle from '$lib/components/ModeToggle.svelte';
	import { ModeWatcher } from 'mode-watcher';
	import '../app.css';

	let { children } = $props();
</script>

<svelte:head>
	<title>goodreads-db-viewer</title>
</svelte:head>

<ModeWatcher />
<ModeToggle />
{@render children()}
