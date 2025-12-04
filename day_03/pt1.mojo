fn get_highest_joltage_pair(battery_joltages: List[Int]) -> Tuple[Int, Int]:
    debug_assert(len(battery_joltages) >= 2, "Need at least 2 joltages to find a pair")

    highest_joltage = -1
    best_second = -1
    for joltage in battery_joltages[:len(battery_joltages)-1]:
        if joltage > highest_joltage:
            highest_joltage = joltage
            best_second = -1
        else:
            best_second = max(best_second, joltage)
    
    return (highest_joltage, max(best_second, battery_joltages[len(battery_joltages)-1]))


fn main() raises:
    with open("day_03/input.txt", "r") as file:
        data = file.read()

    sum_of_joltages = 0
    for line in data.splitlines():
        battery_joltages = [Int(char) for char in line.codepoint_slices()]
        if not battery_joltages:
            continue
        tens_digit, ones_digit = get_highest_joltage_pair(battery_joltages)
        joltage_of_bank = tens_digit * 10 + ones_digit
        sum_of_joltages += joltage_of_bank

    print(sum_of_joltages)

# 16993