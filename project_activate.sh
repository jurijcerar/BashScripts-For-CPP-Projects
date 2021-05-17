#!/bin/bash
if [ -f "./Makefile" ]; then
	if [[ "$1" = "-h" ]]; then
		echo "project_active.sh [-h]"
		echo "you must run this program inside the main project directory"
		echo "add -h for help"
	else
		export IME=$(pwd | cut -d'_' -f 2 | cut -d'.' -f 1)
		export PROJECT_PATH=$(pwd)
		export PATH="$PATH:$(pwd)/build"
		touch $(pwd)/my_bashrc
		echo "source ~/.bashrc" >> $(pwd)/my_bashrc
		echo 'export PS1="'"$IME"':~$"' >> $(pwd)/my_bashrc
		bash --rcfile $(pwd)/my_bashrc
	fi
else
	echo "you must run this program inside the main project directory"
fi
