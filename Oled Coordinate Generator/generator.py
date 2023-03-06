from PIL import Image
import numpy as np

img = Image.open("./images/test.png")
img = np.array(img)

output = ""

for row in range(0, 64):
  for col in range(0, 95):
    if (img[row][col][3] == 255):
      output += f" (x == {col + 1} && y == {row + 1}) ||"

output = "(" + output[1:-3] + ")"

with open('output.txt', 'w') as f:
    f.writelines(output)

f.close()