@fieldwise_init
struct InclusiveRange(Copyable, Movable, Equatable):
    var start: Int
    var end: Int

    fn __eq__(self, other: InclusiveRange) -> Bool:
        return self.start == other.start and self.end == other.end
    
    fn __contains__(self, value: Int) -> Bool:
        return value >= self.start and value <= self.end


fn parse_inventory(content: String) raises -> Tuple[List[InclusiveRange], List[Int]]:
    ingredient_ids: List[Int] = []
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
            ingredient_ids.append(Int(line))
    
    return (id_ranges^, ingredient_ids^)


fn main() raises:
    with open("day_05/input.txt", "r") as file:
        data = file.read()

    fresh_ingredients_count = 0
    inventory = parse_inventory(data)
    # I don't know why I needed to copy like this...
    id_ranges = inventory[0].copy()
    ingredient_ids = inventory[1].copy()
    for ingredient_id in ingredient_ids:
        for id_range in id_ranges:
            if ingredient_id in id_range:
                # print("Ingredient {} is fresh!".format(ingredient_id))
                fresh_ingredients_count += 1
                break

    print(fresh_ingredients_count)
