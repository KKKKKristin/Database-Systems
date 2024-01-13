# import math

# def main():
#     R =36
#     r = 9
#     a = 30
#     nRev = 8
#     limit_t = nRev * math.pi
#     x = 0
#     y = 0
#     t = 0
#     scalingConstant = 0.000025

#     while t <= limit_t:
#         x = (R + r) * math.cos((r / R) * t) - a * math.cos((1 + r / R) * t)
#         y = (R + r) * math.sin((r / R) * t) - a * math.sin((1 + r / R) * t)
#         x = x * scalingConstant
#         y = y * scalingConstant
#         x = -118.2852777778 + x
#         y = 34.0205555556 + y
#         print(f"{x:.5f}, {y:.5f},0 ", end="")
#         t += 0.01

# if __name__ == "__main__":
#     main()

import json
import math

def main():
    R = 36
    r = 9
    a = 30
    nRev = 8
    limit_t = nRev * math.pi
    x = 0
    y = 0
    t = 0
    scalingConstant = 0.000025

    # Create a list to store coordinates as dictionaries
    coordinates_list = []

    while t <= limit_t:
        x = (R + r) * math.cos((r / R) * t) - a * math.cos((1 + r / R) * t)
        y = (R + r) * math.sin((r / R) * t) - a * math.sin((1 + r / R) * t)
        x = x * scalingConstant
        y = y * scalingConstant
        x = -118.2852777778 + x
        y = 34.0205555556 + y
        
        # Append the coordinates to the list as a dictionary
        coordinates_list.append({"loc": [round(x,5),round(y,5)]})

        t += 0.1

    # Convert the list to JSON format
    json_data = json.dumps(coordinates_list, indent=2)
    
    # Print the JSON data
    print(json_data)

if __name__ == "__main__":
    main()
