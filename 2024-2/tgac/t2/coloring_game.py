import sys

read_input = sys.stdin.read


def count_white_regions(
    lines: list[str], num_rows: int, num_cols: int
) -> int:
    white = [[char == "." for char in line] for line in lines]
    parent = list(range(num_rows * num_cols + 1))
    label = [[0 for _ in range(num_cols)] for _ in range(num_rows)]
    largest_label = 0

    def find(x: int) -> int:
        if parent[x] != x:
            parent[x] = find(parent[x])  # Path compression
        return parent[x]

    def union(x: int, y: int):
        parent[find(x)] = find(y)

    for i in range(num_rows):
        for j in range(num_cols):
            if not white[i][j]:
                continue

            left = label[i][j - 1]
            above = label[i - 1][j]

            if left and above:
                union(left, above)
                label[i][j] = find(left)
            elif left:
                label[i][j] = find(left)
            elif above:
                label[i][j] = find(above)
            else:
                largest_label += 1
                label[i][j] = largest_label

    # Count unique roots
    return len([i for i in range(1, largest_label + 1) if i == parent[i]])


def parse_input() -> tuple[list[str], int, int]:
    data = read_input().split()
    num_rows, num_cols = int(data[0]), int(data[1])
    lines = data[2:]
    return lines, num_rows, num_cols


def main():
    lines, num_rows, num_cols = parse_input()
    answer = count_white_regions(lines, num_rows, num_cols)
    print(answer)


if __name__ == "__main__":
    main()
