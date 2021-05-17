#!/bin/bash
if [ -f "./Makefile" ]; then
	case "$1" in 
	
		"-h")
			echo "project_test.sh [-hlv] [name]"
			echo "you must run this program inside the main project directory"
			echo "add -h for help"
			echo "add -l for list of tests inside tests folder"
			echo "add -v for valgrind command"
			;;
		"-v")
			if [[ "$2" = "" ]]; then
				all=0;
				success=0;
				for FILE in tests/*
				do
				if [[ $FILE = tests/test_*\.sh ]]; then
					all=$((all+1))
					echo $FILE | cut -d'/' -f 2
					valgrind --quiet --trace-children=yes --error-exitcode=1 bash $FILE
					if [[ "$?" = "0" ]]; then
						echo "success"
						success=$((success+1))
					else
						echo "fail"
					fi
				else
				echo "not a test"
				fi
				done
				echo "$((all-success)) of $all tests failed"
			else
				if [[ -f "./tests/test_$2.sh" ]]; then
					echo "tests/$2" | cut -d'/' -f 2
					bash "tests/test_$2.sh"
					if [[ "$?" = "0" ]]; then
						echo "success"
					else
						echo "fail"
					fi
				else
					echo "file does not exist"
				fi
			fi
			;;
		"-l")
				for FILE in tests/*
				do
				if [[ $FILE = tests/test_*\.sh ]]; then
					echo $FILE | cut -d'_' -f 2 | cut -d'.' -f 1
				fi
				done	
			;;
		*)
			if [[ "$1" = "" ]]; then
				all=0;
				success=0;
				for FILE in tests/*
				do
				if [[ $FILE = tests/test_*\.sh ]]; then
					all=$((all+1))
					echo $FILE | cut -d'/' -f 2
					bash $FILE
					if [[ "$?" = "0" ]]; then
						echo "success"
						success=$((success+1))
					else
						echo "fail"
					fi
				else
				echo "not a test"
				fi
				done
				echo "$((all-success)) of $all tests failed"
			else
				if [ -f "./tests/test_$1.sh" ]; then
					echo "tests/$1" | cut -d'/' -f 2
					bash "tests/test_$1.sh"
					if [[ "$?" = "0" ]]; then
						echo "success"
					else
						echo "fail"
					fi
				else
					echo "file does not exist"
				fi
			fi
			;;
	esac
else
	echo "you must run this program inside the main project directory"	
fi
