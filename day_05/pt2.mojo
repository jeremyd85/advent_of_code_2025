from python import Python

struct SimplifiedInclusiveRangeSet(Movable):
    var _ranges: List[InclusiveRange]

    fn __init__(out self):
        self._ranges = []
    
    fn __contains__(self, number: Int) -> Bool:
        insertion_index = self._find_best_insertion_index(InclusiveRange(number, number))
        return number in self._ranges[insertion_index]

    fn _find_best_insertion_index(self, range: InclusiveRange) -> Int:
        low = 0
        high = len(self._ranges) - 1
        lowest_intersecting_index: Optional[Int] = None
        while low <= high:
            mid_index = low + (high-low) // 2
            current_range = self._ranges[mid_index]
            if current_range == range:
                return mid_index
            if current_range.intersects(range):
                lowest_intersecting_index = mid_index
                high = mid_index - 1
            elif range < current_range:
                high = mid_index - 1
            else:
                low = mid_index + 1

        return lowest_intersecting_index.take() if lowest_intersecting_index else low

    fn as_list(self) -> List[InclusiveRange]:
        return self._ranges.copy()

    fn insert(mut self, new_range: InclusiveRange):
        if len(self._ranges) == 0:
            self._ranges.append(new_range)
            return

        final_merged_range = new_range.copy()

        start_merge_index = self._find_best_insertion_index(new_range)
        end_merge_index = start_merge_index 

        for i in range(start_merge_index, len(self._ranges)):
            current_range = self._ranges[i]
            
            if current_range.intersects(final_merged_range):
                final_merged_range = final_merged_range.merge(current_range)
                end_merge_index = i + 1
            else:
                break

        new_ranges = List(self._ranges[0:start_merge_index:])
        new_ranges.append(final_merged_range)
        new_ranges.extend(self._ranges[end_merge_index::]) 
        
        self._ranges = new_ranges^

            
    
struct InclusiveRange(Copyable, Movable, Equatable, Comparable, ImplicitlyCopyable):
    var start: Int
    var end: Int

    fn __init__(out self, start: Int, end: Int):
        self.start = start
        self.end = end

    fn __lt__(self, other: InclusiveRange) -> Bool:
        return self.start < other.start or (self.start == other.start and self.end < other.end)

    fn __eq__(self, other: InclusiveRange) -> Bool:
        return self.start == other.start and self.end == other.end
    
    fn __contains__(self, value: Int) -> Bool:
        return value >= self.start and value <= self.end
    
    fn intersects(self, other: InclusiveRange) -> Bool:
        return not (self.end < other.start or self.start > other.end)
    
    fn merge(self, other: Self) -> Self:
        return Self(
            start=min(self.start, other.start),
            end=max(self.end, other.end)
        )


fn parse_inventory(content: String) raises -> SimplifiedInclusiveRangeSet:
    id_ranges = SimplifiedInclusiveRangeSet()

    blank_line_found = False
    for line in content.splitlines():
        if line == "":
            blank_line_found = True
            continue
        if not blank_line_found:
            parts = line.split("-")
            start = Int(parts[0])
            end = Int(parts[1])
            id_ranges.insert(InclusiveRange(start=start, end=end))
        else:
            pass
    
    return id_ranges^


fn main() raises:
    with open("/home/jeremy/code/advent_of_code_2025/day_05/example.txt", "r") as file:
        data = file.read()
    py = Python.import_module("builtins")

    id_ranges = parse_inventory(data)
    
    fresh_ingredients_count = py.int(0)
    for id_range in id_ranges.as_list():
        print(id_range.start, id_range.end)
        fresh_in_range = (id_range.end+1) - id_range.start
        print("fresh in range", fresh_in_range)
        fresh_ingredients_count += fresh_in_range

    print(fresh_ingredients_count)

# 344771884978261