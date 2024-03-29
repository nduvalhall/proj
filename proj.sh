#!/bin/bash


function proj() {
    file_path=$(find ~/* -type d - | fzf --reverse)
    cd $file_path
}
