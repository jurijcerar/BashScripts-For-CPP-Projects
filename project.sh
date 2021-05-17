#!/bin/bash
case "$1" in 
	
		"-h")
			echo "project.sh [-h] [name_of_command]"
			echo "new - creates new project"
			echo "add - adds a .h and .cpp file"
			echo "test - tests tests in test folder"
			echo "activate - runs already compiled cpp program"
			;;
		"new")
			bash project_new.sh $2 $3 $4
			;;
		"add")
			bash project_add.sh $2 $3
			;;
		"test")
			bash project_test.sh $2 $3
			;;
		"activate")
			bash project_activate.sh $2
			;;
esac
