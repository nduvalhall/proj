import sys

name_arg = sys.argv[1]

with open("/home/flacdontbetter/.local/share/proj/.config") as f:
    for line in f:
        name, path = line.split(" ")

        if name == name_arg:
            print(path)
            exit()

print("no project")
