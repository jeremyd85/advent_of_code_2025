
@fieldwise_init
struct Point(Copyable, Movable, Equatable):
    var row: Int
    var col: Int

    fn __eq__(self, other: Point) -> Bool:
        return self.row == other.row and self.col == other.col

    fn has_negative_coordinate(self) -> Bool:
        return self.row < 0 or self.col < 0
    
    fn surrounding_points(self) -> List[Point]:
        return [
            Point(row=self.row-1, col=self.col), # Top
            Point(row=self.row+1, col=self.col), # Bottom
            Point(row=self.row, col=self.col-1), # Left
            Point(row=self.row, col=self.col+1), # Right
            Point(row=self.row-1, col=self.col-1), # Top-Left
            Point(row=self.row-1, col=self.col+1), # Top-Right
            Point(row=self.row+1, col=self.col-1), # Bottom-Left
            Point(row=self.row+1, col=self.col+1) # Bottom-Right
        ]

fn is_in_bounds[o: Origin](grid: List[StringSlice[o]], point: Point) -> Bool:
    return point.row < len(grid) and point.col < len(grid[point.row]) and not point.has_negative_coordinate()


fn display_marked_grid[o: Origin](grid: List[StringSlice[o]], points: List[Point], mark: StringSlice):
    for row in range(len(grid)):
        for col in range(len(grid[row])):
            point = Point(row=row, col=col)
            # print(grid[row][col], end="")
            if point in points:
                print(mark, end="")
            else:
                print(grid[row][col], end="")
        print("")

fn is_accessible[o: Origin](grid: List[StringSlice[o]], point: Point) -> Bool:
    paper_roll_count = 0
    for surrounding_point in point.surrounding_points():
        if is_in_bounds(grid, surrounding_point) and grid[surrounding_point.row][surrounding_point.col] == '@':
            paper_roll_count += 1
        
    return paper_roll_count < 4


fn count_accessible_paper_rolls[o: Origin](grid: List[StringSlice[o]]) -> Int:
    marked_points: List[Point] = []
    count = 0
    for row in range(len(grid)):
        for col in range(len(grid[row])):
            if is_accessible(grid, Point(row=row, col=col)) and grid[row][col] == '@':
                marked_points.append(Point(row=row, col=col))
                count += 1
    # display_marked_grid(grid, marked_points, mark='x')
    return count

fn main() raises:
    with open("day_04/input.txt", "r") as file:
        data = file.read()
    # print(data)
    # print("---------------")
    grid = data.splitlines()
    accessible_paper_rolls = count_accessible_paper_rolls(grid^)

    print(accessible_paper_rolls)

# 1540