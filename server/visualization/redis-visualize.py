import matplotlib.pyplot as plt
import numpy as np

# Data directly from your provided benchmark results
operations = ['PING_INLINE', 'PING_MBULK', 'SET', 'GET', 'INCR', 'LPUSH', 'RPUSH', 
              'LPOP', 'RPOP', 'SADD', 'HSET', 'SPOP', 'ZADD', 'ZPOPMIN', 
              'LPUSH', 'LRANGE_100', 'LRANGE_300', 'LRANGE_500', 'LRANGE_600', 'MSET', 'XADD']

# Server emulated data
emulated_data = [43898.15, 53850.30, 40080.16, 45934.77, 44208.66, 33829.50, 40950.04, 
                 16189.09, 35038.54, 42643.92, 37678.97, 48685.49, 34542.32, 48685.49, 
                 33647.38, 6619.45, 2524.30, 1572.08, 1320.85, 14583.64, 24102.19]
emulated_data = emulated_data[:len(operations)//2]
p50_emulated = [0.911, 0.767, 1.271, 0.879, 0.895, 1.415, 1.191, 2.783, 1.407, 0.967, 
                1.351, 0.823, 1.503, 0.823, 1.391, 7.671, 19.071, 30.735, 36.671, 3.839, 1.647]

# Server native data
native_data = [117785.63, 105596.62, 110497.24, 105820.11, 106951.88, 110497.24, 110864.74, 
               108577.63, 108108.11, 108932.46, 116686.12, 107642.62, 109051.26, 105708.25, 
               113250.28, 72358.90, 29559.56, 19175.46, 16369.29, 132275.14, 113250.28]
# Only include half of the data for better visualization
native_data = native_data[:len(operations)//2]
p50_native = [0.207, 0.239, 0.231, 0.239, 0.239, 0.231, 0.231, 0.239, 0.239, 0.231, 
              0.223, 0.239, 0.239, 0.239, 0.231, 0.343, 0.847, 1.295, 1.519, 0.207, 0.231]

# calculate average latency increase in % relative to native
average_latency_increase = []
for emulated, native in zip(p50_emulated, p50_native):
    average_latency_increase.append((emulated - native) / native)
average_latency_increase = np.average(average_latency_increase) * 100
print(f'Average latency increase: {average_latency_increase:.2f}%')

# Prepare for Chart Creation
x = np.arange(len(operations)//2) 
width = 0.35  

# Create the bars
fig, ax = plt.subplots()
rects1 = ax.bar(x - width/2, emulated_data, width, label='Emulated', color='blue')
rects2 = ax.bar(x + width/2, native_data, width, label='Native', color='orange')

# Add latency labels
def add_latency_labels(rects, latency_data):
    for rect, latency in zip(rects, latency_data):
        height = rect.get_height()
        #ax.text(rect.get_x() + rect.get_width()/2, height + 1000, 
        #        f'p50: {latency}ms', ha='center', va='bottom')

add_latency_labels(rects1, p50_emulated)
add_latency_labels(rects2, p50_native)

# Labels, title, and display
ax.set_ylabel('Requests per Second')
ax.set_title('Server Emulated vs. Native Benchmark')
ax.set_xticks(x, operations[:len(operations)//2])
ax.legend()
plt.show()
