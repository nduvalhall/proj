function proj() {
    file_path="/home/$(whoami)/.local/share/proj/.config"
    file=$(cat $file_path)


    if [[ $# -eq 0 ]]; then
        echo "usage: proj [options] [project name]"
        echo "options:"
        echo "  --list, -l: list all projects"
        echo "  --add, -a: add project"
        echo "  --remove, -r: remove project"
        echo "  --help, -h: show this message"
        echo "  --version, -v: show version"
        echo "  --open, -o: open project"
        return 1
    fi


    if [[ $1 == "--version" || $1 == "-v" ]]; then
        echo "proj version 0.2"
        return 0
    fi


    if [[ $1 == "--help" || $1 == "-h" ]]; then
        echo "usage: proj [options] [project name]"
        echo "options:"
        echo "  --list, -l: list all projects"
        echo "  --add, -a: add project"
        echo "  --remove, -r: remove project"
        echo "  --help, -h: show this message"
        echo "  --version, -v: show version"
        echo "  --open, -o: open project"
        return 0
    fi


    if [[ $1 == "--list" || $1 == "-l" ]]; then
        cat $file_path
        return 0
    fi


    if [[ $1 == "--add" || $1 == "-a" ]]; then


        if [[ $2 == "" || $3 == "" ]]; then
            echo "usage: proj --add [project name] [project path]"
            return 1

        else
            count=$(grep -c "$2 " $file_path)

            if [[ $count -gt 0 ]]; then
                echo "project '$2' already exists"
                return 1
            fi

            name=$2
            path=$(realpath $3)
            echo "$name $path" >> $file_path
            echo "Added project '$name' with path '$path'"
            return 0
        fi
    fi


    if [[ $1 == "--remove" || $1 == "-r" ]]; then

        if [[ $2 == "" ]]; then
            echo "usage: proj --remove [project name]"
            return 1

        else
            count=$(grep -c "$2 " $file_path)

            if [[ $count -eq 0 ]]; then
                echo "project '$2' not found"
                return 1
            fi

            name=$2
            sed -i "/$name /d" $file_path
            echo "Removed project '$name'"
            return 0
        fi
    fi

    if [[ $1 == "--open" || $1 == "-o" ]]; then

        if [[ $2 == "" ]]; then
            echo "usage: proj --open [project name]"
            return 1

        else
            count=$(grep -c "$2 " $file_path)

            if [[ $count -eq 0 ]]; then
                echo "project '$2' not found"
                return 1
            fi

            name=$2
            path=$(grep "$name " $file_path | cut -d' ' -f2)
            cd $path
            return 0
        fi
    fi
}
