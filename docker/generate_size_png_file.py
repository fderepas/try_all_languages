# to install matplotlib:
#    python -m pip install -U pip
#    python -m pip install -U matplotlib
import matplotlib.pyplot as plt
import numpy as np
import json
 
f = open('image_size.json')
data = json.load(f)
f.close()
l=list(data.keys())
v=list([data[i] for i in l])

sorted_image_by_size = sorted(data.items(), key=lambda x:x[1])
#print(sorted_image_by_size)
#print([l[1] for l in sorted_image_by_size])

x = np.arange(len(l))
plt.bar(x, height=[l[1] for l in sorted_image_by_size])
plt.xticks(x, [l[0] for l in sorted_image_by_size], rotation='vertical');

plt.hist(x, density=True, bins=30)  # density=False would make counts
# Tweak spacing to prevent clipping of tick-labels
plt.subplots_adjust(bottom=0.3)

plt.ylabel('Image size in Go')
plt.xlabel('Language');
plt.savefig('docker_image_size_by_language.png')
