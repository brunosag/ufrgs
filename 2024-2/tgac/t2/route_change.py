import heapq


def shortest_path_cost(graph: list[dict[int]], start: int, target: int):
    distances = {node: float("inf") for node in range(len(graph))}
    distances[start] = 0
    pq = [(0, start)]

    while pq:
        current_distance, current_node = heapq.heappop(pq)

        if current_node == target:
            return current_distance

        if current_distance > distances[current_node]:
            continue

        for neighbor, weight in graph[current_node].items():
            distance = current_distance + weight
            if distance < distances[neighbor]:
                distances[neighbor] = distance
                heapq.heappush(pq, (distance, neighbor))

    return float("inf")


def solve(
    roads: list[tuple[int, int, int]],
    num_cities: int,
    route_size: int,
    repair_city: int,
) -> int | float:
    graph: list[dict[int]] = [{} for _ in range(num_cities)]

    for road in roads:
        c1, c2, cost = road
        if not (c1 < route_size and c1 + 1 != c2):
            graph[c1][c2] = cost
        if not (c2 < route_size and c2 + 1 != c1):
            graph[c2][c1] = cost

    min_cost = shortest_path_cost(graph, repair_city, route_size - 1)

    return min_cost


def main():
    while True:
        num_cities, num_roads, route_size, repair_city = map(
            int, input().split()
        )

        if (num_cities, num_roads, route_size, repair_city) == (0, 0, 0, 0):
            return

        roads: list[tuple[int, int, int]] = [
            tuple((map(int, input().split()))) for _ in range(num_roads)
        ]
        answer = solve(
            roads=roads,
            num_cities=num_cities,
            route_size=route_size,
            repair_city=repair_city,
        )

        print(answer)


if __name__ == "__main__":
    main()
