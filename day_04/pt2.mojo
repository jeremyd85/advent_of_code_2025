
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

fn is_in_bounds(grid: List[String], point: Point) -> Bool:
    return point.row < len(grid) and point.col < len(grid[point.row]) and not point.has_negative_coordinate()


fn display_marked_grid(grid: List[String], points: List[Point], mark: StringSlice):
    for row in range(len(grid)):
        for col in range(len(grid[row])):
            point = Point(row=row, col=col)
            if point in points:
                print(mark, end="")
            else:
                print(grid[row][col], end="")
        print("")

fn is_accessible(grid: List[String], point: Point) -> Bool:
    paper_roll_count = 0
    for surrounding_point in point.surrounding_points():
        if is_in_bounds(grid, surrounding_point) and grid[surrounding_point.row][surrounding_point.col] == '@':
            paper_roll_count += 1
        
    return paper_roll_count < 4


fn get_accessible_paper_rolls(grid: List[String]) -> List[Point]:
    marked_points: List[Point] = []
    for row in range(len(grid)):
        for col in range(len(grid[row])):
            if is_accessible(grid, Point(row=row, col=col)) and grid[row][col] == '@':
                marked_points.append(Point(row=row, col=col))
    # display_marked_grid(grid, marked_points, mark='x')
    return marked_points^


fn main() raises:
    with open("day_04/input.txt", "r") as file:
        data = file.read()
    # print(data)
    # print("---------------")
    grid = data.splitlines()
    current_grid = [String(row) for row in grid]
    
    paper_rolls_removed = 0
    accessible_paper_rolls = get_accessible_paper_rolls(current_grid)
    while accessible_paper_rolls:
        paper_rolls_removed += len(accessible_paper_rolls)
        
        for point in accessible_paper_rolls:

            var row = current_grid[point.row]
            row = row[:point.col] + '.' + row[point.col+1:]
            current_grid[point.row] = row

        accessible_paper_rolls = get_accessible_paper_rolls(current_grid)
    print(paper_rolls_removed)

# 8972