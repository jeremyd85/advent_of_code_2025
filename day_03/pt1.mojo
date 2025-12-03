fn get_highest_joltage_pair(battery_joltages: List[Int]) -> Tuple[Int, Int]:
    highest_joltage = -1
    best_second = -1
    for joltage in battery_joltages[:len(battery_joltages)-1]:
        if joltage > highest_joltage:
            highest_joltage = joltage
            best_second = -1
        else:
            best_second = max(best_second, joltage)
    
    return (highest_joltage, max(best_second, battery_joltages[len(battery_joltages)-1]))


def display_bytes(data: Span[Byte]) -> None:
    for byte in data:
        print("byte", byte)

fn main() raises:
    with open("day_03/input.txt", "r") as file:
        data = file.read()

    sum_of_joltages = 0
    i = 0
    for line in data.split("\n"):
        print("line", i)
        print("del is trivial", line.__del__is_trivial)
        print("copy is trivial", line.__copyinit__is_trivial)
        print("move is trivial", line.__moveinit__is_trivial)
        display_bytes(line.as_bytes())
        print("After display_bytes")
        battery_joltages = [Int(char) for char in line.codepoint_slices()]
        tens_digit, ones_digit = get_highest_joltage_pair(battery_joltages)
        joltage_of_bank = tens_digit * 10 + ones_digit
        sum_of_joltages += joltage_of_bank
        i += 1

    print(sum_of_joltages)

# 16993