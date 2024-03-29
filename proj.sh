#!/bin/bash


function proj() {

    # Check if file exists, if not create it
    file_path="/home/$(whoami)/.local/share/proj/.config"
    
    if [[ ! -f $file_path ]]; then
        mkdir -p /home/$(whoami)/.local/share/proj
        touch $file_path
    fi

    file=$(cat $file_path)


    # if no arguments are passed, show fzf
    if [[ $# -eq 0 ]]; then
        project_path=$(cat $file_path | fzf --reverse)
        project=$(echo $project_path | cut -d' ' -f1)
        path=$(echo $project_path | cut -d' ' -f2)

        if [[ $project == "" ]]; then
            return 1
        fi

        cd $path
        return 0
    fi


    # if first agument is not '--' or '-'
    if [[ $1 != -* ]]; then
        
        # check if project exists
        count=$(grep -c "$1 " $file_path)

        if [[ $count -eq 0 ]]; then
            echo "project '$1' not found"
            return 1
        fi

        # open project
        name=$1
        path=$(grep "$name " $file_path | cut -d' ' -f2)
        cd $path
        return 0
    fi


    # if first argument is --version or -v, show version
    if [[ $1 == "--version" || $1 == "-v" ]]; then
        echo "proj version 0.2"
        return 0
    fi


    # if first argument is --help or -h, show help
    if [[ $1 == "--help" || $1 == "-h" ]]; then
        echo "usage: proj [project name] | [options] ..."
        echo "options:"
        echo "  --list, -l: list all projects"
        echo "  --add, -a: add project"
        echo "  --remove, -r: remove project"
        echo "  --help, -h: show this message"
        echo "  --version, -v: show version"
        echo "  --open, -o: open project"
        return 0
    fi


    # if first argument is --list or -l, list all projects
    if [[ $1 == "--list" || $1 == "-l" ]]; then

        # check if file is empty
        if [[ ! -s "$file_path" ]]; then
            echo "no projects found, use 'proj --add' to add a project"
            return 1
        fi

        # list all projects
        cat $file_path
        return 0
    fi


    # if first argument is --add or -a, add project
    if [[ $1 == "--add" || $1 == "-a" ]]; then


        # if no arguments are passed, show help
        if [[ $2 == "" || $3 == "" ]]; then
            echo "usage: proj --add [project name] [project path]"
            return 1

        else

            # check if project already exists
            count=$(grep -c "$2 " $file_path)

            if [[ $count -gt 0 ]]; then
                echo "project '$2' already exists"
                return 1
            fi

            # add project
            name=$2
            path=$(realpath $3)
            echo "$name $path" >> $file_path
            echo "added project '$name' with path '$path'"
            return 0
        fi
    fi


    # if first argument is --remove or -r, remove project
    if [[ $1 == "--remove" || $1 == "-r" ]]; then

        # if no arguments are passed, show help
        if [[ $2 == "" ]]; then
            echo "usage: proj --remove [project name]"
            return 1

        else

            # check if project exists
            count=$(grep -c "$2 " $file_path)

            if [[ $count -eq 0 ]]; then
                echo "project '$2' not found"
                return 1
            fi

            # remove project
            name=$2
            after=$(sed "/$name /d" $file_path)
            echo "$after" > $file_path

            echo "removed project '$name'"
            return 0
        fi
    fi


    # if first argument is --open or -o, open project
    if [[ $1 == "--open" || $1 == "-o" ]]; then

        # if no arguments are passed, show help
        if [[ $2 == "" ]]; then
            echo "usage: proj --open [project name]"
            return 1

        else

            # check if project exists
            count=$(grep -c "$2 " $file_path)

            if [[ $count -eq 0 ]]; then
                echo "project '$2' not found"
                return 1
            fi

            # open project
            name=$2
            path=$(grep "$name " $file_path | cut -d' ' -f2)
            cd $path
            return 0
        fi
    fi
}
