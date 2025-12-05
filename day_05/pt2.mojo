from collections import set

@fieldwise_init
struct InclusiveRange(Copyable, Movable, Equatable):
    var start: Int
    var end: Int

    fn __eq__(self, other: InclusiveRange) -> Bool:
        return self.start == other.start and self.end == other.end
    
    fn __contains__(self, value: Int) -> Bool:
        return value >= self.start and value <= self.end


fn parse_inventory(content: String) raises -> List[InclusiveRange]:
    id_ranges: List[InclusiveRange] = []

    blank_line_found = False
    for line in content.splitlines():
        if line == "":
            blank_line_found = True
            continue
        if not blank_line_found:
            parts = line.split("-")
            debug_assert(len(parts) == 2, "Each range line must contain exactly one '-' character")
            
            start = Int(parts[0])
            end = Int(parts[1])
            id_ranges.append(InclusiveRange(start=start, end=end))
        else:
            pass
    
    return id_ranges^


fn main() raises:
    with open("day_05/input.txt", "r") as file:
        data = file.read()

    id_ranges = parse_inventory(data)
    
    fresh_ingredients_count = 0
    for id_range in id_ranges:
        for i in range(id_range.start, id_range.end + 1):
            for id_range1 in id_ranges:
                if 

    print(len(fresh_ingredients))
