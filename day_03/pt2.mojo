fn get_highest_joltage_batteries(battery_joltages: List[Int], count: Int) -> List[Int]:
    best_joltages: List[Int] = []
    for joltage in battery_joltages:
        best_joltages.append(joltage)

        if len(best_joltages) <= count:
            continue

        for i, joltage in enumerate(best_joltages):
            if i == (len(best_joltages)-1) or joltage < best_joltages[i+1]:
                _ = best_joltages.pop(i)
                break

    return best_joltages^


fn digits_to_number(digits: List[Int]) -> Int:
    number = 0
    for i, digit in enumerate(digits[::-1]):
        number += digit * (10 ** i)
    return number


fn main() raises:
    with open("day_03/input.txt", "r") as file:
        data = file.read()

    sum_of_joltages = 0
    for line in data.split("\n"):
        battery_joltages = [Int(char) for char in line.codepoint_slices()]
        joltages = get_highest_joltage_batteries(battery_joltages, 12)
        joltage_of_bank = digits_to_number(joltages)
        sum_of_joltages += joltage_of_bank

    print(sum_of_joltages)

# 168617068915447