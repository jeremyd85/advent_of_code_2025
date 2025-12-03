fn rotate_lock(position: Int, command: StringSlice) raises -> Int:
    steps = Int(command[1:])

    if command.startswith("R"):
        return (position + steps) % 100
    return (position - steps) % 100

fn main() raises:
    with open("day_01/input.txt", "r") as file:
        data = file.read()

    position = 50
    zero_count = 0
    for command in data.splitlines():
        position = rotate_lock(position, command)
        if position == 0:
            zero_count += 1
    
    print(zero_count)

# 980