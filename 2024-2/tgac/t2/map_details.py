import sys
from itertools import islice

read_input = sys.stdin.read


def minimum_span_length(
    num_cities: int, num_roads: int, roads: list[tuple[int, int, int]]
) -> int:
    sorted_roads = sorted(roads, key=lambda road: road[2])
    trees = list(range(num_cities + 1))

    def find(x: int) -> int:
        if x != trees[x]:
            trees[x] = find(trees[x])  # Path compression
        return trees[x]

    def union(x: int, y: int):
        trees[find(x)] = find(y)

    total_length = 0
    for road in sorted_roads:
        if find(road[0]) != find(road[1]):
            total_length += road[2]
            union(road[0], road[1])

    return total_length


def parse_input() -> tuple[int, int, list[tuple[int, int, int]]]:
    data = map(int, read_input().split())
    num_cities, num_roads = next(data), next(data)
    roads = [tuple(islice(data, 3)) for _ in range(num_roads)]
    return num_cities, num_roads, roads


def main():
    num_cities, num_roads, roads = parse_input()
    answer = minimum_span_length(num_cities, num_roads, roads)
    print(answer)


if __name__ == "__main__":
    main()
