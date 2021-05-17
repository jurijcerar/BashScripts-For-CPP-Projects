#!/bin/bash
if [ -f "./Makefile" ]; then
	if [[ "$2" = "-h" || "$1" = "-h" ]]; then
		echo "project_new.sh <name> [-h]"
		echo "you must run this program inside the main project directory"
		echo "add -h for help"
	else
		if [ ! -f "./src/$1.cpp" ]; then
			touch "./src/$1.cpp"
			echo '#include "'"$1.h"'"' >> "./src/$1.cpp"
		else
			echo "file already exists!"
		fi
		if [ ! -f "./include/$1.h" ]; then
			touch "./include/$1.h"
			echo "#ifndef $1_H_" >> "./include/$1.h"
			echo "#define $1_H_" >>"./include/$1.h"
			echo >> "./include/$1.h"
			echo "// tukaj implementirate funkcionalnosti objekta $1" >> "./include/$1.h"
			echo >> "./include/$1.h"
			echo "#endif // $1_H_" >> "./include/$1.h"
		else
			echo "file already exists!"
		fi
	fi
else
	echo "you must run this program inside the main project directory"
fi
