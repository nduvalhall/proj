#!/bin/bash

function proj() {
	proj_path=$HOME/.local/share/proj
	config_file=$proj_path/config

	if [ ! -f $config_file ]; then
		if [ ! -d $proj_path ]; then
			mkdir -p $proj_path
		fi
		touch $config_file
	fi

	if [[ $1 == "add" || $1 == "a" ]]; then
		echo $(pwd) >>$config_file
		echo "Added $(pwd) to proj"
		return
	fi

	if [[ $1 == "remove" || $1 == "r" ]]; then
		file_path=$(cat $config_file | fzf --reverse)
		touch $proj_path/temp

		while read -r line; do
			if [ "$line" != "$file_path" ]; then
				echo $line >>$proj_path/temp
			fi
		done <$config_file

		mv $proj_path/temp $config_file
		echo "Removed $file_path from proj"
		return
	fi

	file_path=$(cat $config_file | fzf --reverse)

	if [[ $file_path == "" ]]; then
		return
	fi

	cd $file_path
	clear
}
