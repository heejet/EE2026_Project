from PIL import Image
import numpy as np

count = 35
img = Image.open(f"./images/siuuuuu/siu ({count}).png")
img = np.array(img)

# retrieved from https://stackoverflow.com/questions/1969240/mapping-a-range-of-values-to-another
def translate(value, leftMin, leftMax, rightMin, rightMax):
    # Figure out how 'wide' each range is
    leftSpan = leftMax - leftMin
    rightSpan = rightMax - rightMin

    # Convert the left range into a 0-1 range (float)
    valueScaled = float(value - leftMin) / float(leftSpan)

    # Convert the 0-1 range into a value in the right range.
    return rightMin + (valueScaled * rightSpan)

output = ""

# img[0] -> R (5-bits = 0 - 31), img[1] -> G (6-bits = 0 - 63), img[2] -> B (5-bits = 0 - 31)

i = 0

for row in range(0, 64):
  for col in range(0, 96):
    R = int(translate(img[row][col][0], 0, 255, 0, 31))
    G = int(translate(img[row][col][1], 0, 255, 0, 63))
    B = int(translate(img[row][col][2], 0, 255, 0, 31))
    if (R != 0 or G != 0 or B != 0):
      output += f"{i}: oled_data <= "
      output += "16'b"
      output += format(R, '05b')
      output += format(G, '06b')
      output += format(B, '05b')
      output += ";\n"
    i = i + 1

output += "default: oled_data <= 16'b0;"

with open('output.txt', 'w') as f:
    f.writelines(output)

f.close()