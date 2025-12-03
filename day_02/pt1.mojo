fn is_valid_product_id(product_id: Int) -> Bool:
    product_id_str = String(product_id)
    if len(product_id_str) % 2 != 0:
        return True
    return product_id_str[:len(product_id_str) // 2] != product_id_str[len(product_id_str) // 2:]

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

# 41294979841