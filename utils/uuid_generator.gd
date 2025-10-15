class_name UUIDGenerator

# Generates a random UUID version 4
static func generate_uuid() -> String:
    var rng = RandomNumberGenerator.new()
    rng.randomize()  # Ensure the RNG is seeded for randomness
    
    # UUID format: xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
    var uuid = ""
    
    # Generate the first part: 8 random hex digits
    uuid += _generate_hex(8, rng)
    uuid += "-"
    
    # Generate the second part: 4 random hex digits
    uuid += _generate_hex(4, rng)
    uuid += "-"
    
    # Generate the third part: '4' followed by 3 random hex digits
    uuid += "4"  # UUID version 4
    uuid += _generate_hex(3, rng)
    uuid += "-"
    
    # Generate the fourth part: 'y' (8, 9, a, or b) followed by 3 random hex digits
    var y = ["8", "9", "a", "b"][rng.randi_range(0, 3)]
    uuid += y
    uuid += _generate_hex(3, rng)
    uuid += "-"
    
    # Generate the fifth part: 12 random hex digits
    uuid += _generate_hex(12, rng)
    
    return uuid

# Helper function to generate a string of random hex digits of given length
static func _generate_hex(length: int, rng: RandomNumberGenerator) -> String:
    var hex_digits = "0123456789abcdef"
    var result = ""
    for i in range(length):
        result += hex_digits[rng.randi_range(0, 15)]
    return result