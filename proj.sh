function proj() {
    file_path="/home/$(whoami)/.local/share/proj/.config"
    file=$(cat $file_path)

    if [[ $1 == "--list" || $1 == "-l" ]]; then
        cat $file_path

    elif [[ $1 == "--add" || $1 == "-a" ]]; then
        name=$2
        path=$(realpath $3)
        echo "$name $path" >> $file_path

    elif [[ $1 == "--remove" || $1 == "-r" ]]; then
        name=$2
        python3.10 "/home/flacdontbetter/proj/remove.py" $2


    elif [[ $1 != "" ]]; then
        path=$(python3.10 "/home/flacdontbetter/proj/open.py" $1)

        if [[ $path == "no project" ]]; then
            echo "no project with name '$1'"    
        else
            cd $path
        fi
    fi 
}
