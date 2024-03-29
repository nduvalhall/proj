#!/bin/bash


function proj() {
    file_path=$(find ~/* -type d | fzf --reverse)
    if [[ -z "$file_path" ]]; then
        return
    fi
    cd $file_path
}
