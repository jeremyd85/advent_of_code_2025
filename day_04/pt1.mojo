
@fieldwise_init
struct Point(Copyable, Movable):
    var row: Int
    var col: Int

    fn has_negative_coordinate(self) -> Bool:
        return self.row < 0 or self.col < 0
    
    fn surrounding_points(self) -> List[Point]:
        return [
            Point(row=self.row-1, col=self.col),
            Point(row=self.row+1, col=self.col),
            Point(row=self.row, col=self.col-1),
            Point(row=self.row, col=self.col+1),
            Point(row=self.row-1, col=self.col-1),
            Point(row=self.row-1, col=self.col+1),
            Point(row=self.row+1, col=self.col-1),
            Point(row=self.row+1, col=self.col+1)
        ]

fn is_in_bounds(grid: List[StringSlice], point: Point) -> Bool:
    return point.row < len(grid) and point.col < len(grid[point.row]) and not point.has_negative_coordinate()


fn is_accessable(grid: List[StringSlice], point: Point) -> Bool:
    paper_roll_count = 0
    for point in point.surrounding_points():
        if is_in_bounds(grid, point) and grid[point.row][point.col] == '@':
            paper_roll_count += 1
    return paper_roll_count < 4


fn count_accessable_paper_rolls(grid: List[StringSlice]) -> Int:
    count = 0
    for row in range(len(grid)):
        for col in range(len(grid[row])):
            if is_accessable(grid, Point(row=row, col=col)):
                count += 1
    return count

fn main() raises:
    with open("day_04/input.txt", "r") as file:
        data = file.read()

    grid = data.splitlines()
    accessable_paper_rolls = count_accessable_paper_rolls(grid^)

    print(accessable_paper_rolls)