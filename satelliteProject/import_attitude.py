import bpy
import csv

# -------- USER SETTINGS --------
csv_path = r"C:\Users\vanil\Downloads\satelliteProject\quaternionCSV.txt"  # use raw string
sat_name = "sat_body"
fps = 100       # match MATLAB dt = 0.01
sample_step = 10  # pick every 10th row to reduce frames
# --------------------------------

sat = bpy.data.objects[sat_name]
sat.rotation_mode = 'QUATERNION'

# Clear old animation
sat.animation_data_clear()

# Read CSV into memory
quaternions = []
with open(csv_path, newline='') as csvfile:
    reader = csv.DictReader(csvfile)
    for row in reader:
        w = float(row['q0'])
        x = float(row['q1'])
        y = float(row['q2'])
        z = float(row['q3'])
        quaternions.append((w, x, y, z))

# Downsample to reduce load
quaternions = quaternions[::sample_step]

# Insert keyframes
for i, quat in enumerate(quaternions):
    frame = i + 1
    bpy.context.scene.frame_set(frame)
    sat.rotation_quaternion = quat
    sat.keyframe_insert(data_path="rotation_quaternion", frame=frame)

# Scene timing
scene = bpy.context.scene
scene.frame_start = 1
scene.frame_end = len(quaternions)
scene.render.fps = fps

print(f"Inserted {len(quaternions)} keyframes.")
