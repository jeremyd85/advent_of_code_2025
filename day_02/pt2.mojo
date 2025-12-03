import math

fn is_valid_product_id(product_id: Int) -> Bool:
    product_id_str = String(product_id)
    for split_number in range(1, len(product_id_str) // 2 + 1):
        if len(product_id_str) % split_number != 0:
            continue
        comparison_str = product_id_str[:split_number]
        all_match = True
        for i in range(1, len(product_id_str) // split_number):
            if comparison_str != product_id_str[i*split_number:i*split_number+split_number]:
                all_match = False
                break
        if all_match:
            return False
    return True


fn main() raises:
    with open("day_02/input.txt", "r") as file:
        data = file.read()
    
    invalid_product_id_sum = 0
    for range_str in data.split(","):
        bounds = range_str.split("-")
        lower = Int(bounds[0])
        upper = Int(bounds[1])
        for product_id in range(lower, upper + 1):
            if not is_valid_product_id(product_id):
                invalid_product_id_sum += product_id
    
    print(invalid_product_id_sum)

# 66500947346