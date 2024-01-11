import sys

name_arg = sys.argv[1]

with open("/home/flacdontbetter/.local/share/proj/.config", "r") as f:
    lines = f.readlines()

with open("/home/flacdontbetter/.local/share/proj/.config", "w") as f:
    for line in lines:
        if line.split(" ")[0] != name_arg:
            f.write(line)
