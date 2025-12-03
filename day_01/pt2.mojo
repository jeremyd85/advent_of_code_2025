fn rotate_lock(position: Int, command: StringSlice) raises -> Tuple[Int, Int]:
    steps = Int(command[1:])
    adjustment = 0

    if command.startswith("R"):
        passes, new_position = divmod(position + steps, 100)
    else:
        # Handle edge cases of negative modulo
        # Starting at 0 and moving left SHOULD NOT count as a full pass
        if position == 0:
            adjustment = -1
        passes, new_position = divmod(position - steps, 100)
        # Landing on 0 after moving left SHOULD count as a full pass
        if new_position == 0:
            adjustment += 1
    
    return abs(passes) + adjustment, new_position

fn main() raises:
    with open("day_01/input.txt", "r") as file:
        data = file.read()

    position = 50
    zero_count = 0
    for command in data.splitlines():
        passes, position = rotate_lock(position, command)
        zero_count += passes
    
    print(zero_count)

# 5961