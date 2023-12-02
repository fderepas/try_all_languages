import matplotlib.pyplot as plt
import numpy as np
import json
 
f = open('execution_time.json')
dataRaw = json.load(f)
f.close()
data={}
for i in dataRaw:
    v=dataRaw[i];
    data[i]=sum(v)/len(v)
l=list(data.keys())
print (data)
sorted_image_by_size = sorted(data.items(), key=lambda x:x[1])
x = np.arange(len(l))
plt.bar(x, height=[l[1] for l in sorted_image_by_size])
plt.xticks(x, [l[0] for l in sorted_image_by_size], rotation='vertical');

plt.hist(x, density=True, bins=30)  # density=False would make counts
# Tweak spacing to prevent clipping of tick-labels
plt.subplots_adjust(bottom=0.3)

plt.ylabel('Execution time')
plt.xlabel('Language');
plt.savefig('docker_time_by_language.png')
