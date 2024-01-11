with open("/home/flacdontbetter/.local/share/proj/.config") as f:
    for line in f:
        name, path = line.split(" ")
        print(f"{name} -> {path}")
