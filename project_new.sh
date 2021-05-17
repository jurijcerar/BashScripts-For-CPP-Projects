#!/bin/bash
function create {
	dir="$2/project_$1"
	if [ ! -d "$dir" ]; then
		dir="$2/project_$1"
		mkdir "$dir"
		mkdir "$dir/src"
		touch "$dir/src/main.cpp"
		echo "#include <iostream>" >> "$dir/src/main.cpp"
		echo "int main() {" >>"$dir/src/main.cpp"
		echo 'std::cout << "Hello World!"<<std::endl;' >> "$dir/src/main.cpp"
		echo "return 0;" >> "$dir/src/main.cpp"
		echo "}" >> "$dir/src/main.cpp"
		mkdir "$dir/include"
		mkdir "$dir/build"
		mkdir "$dir/tests"
		touch "$dir/Makefile"
		mkfile='# prevajalnik za C++
CXX= g++
# dodatne zastavice, ki se posredujejo prevajalniku
CXXFLAGS= -Wall -Iinclude
# ime cilja - programa v katerega prevedemo program
TARGET= '"$1"'

# avtomatsko iskanje izvornih datotek, v src in trenutnem direktoriju
SRCS := $(wildcard src/*.cpp *.cpp)
OBJS := $(SRCS:src/%.cpp=build/%.o)

# izpis informacij
$(info Compiler: $(CXX))
$(info Flags: $(CXXFLAGS))
$(info Target: $(TARGET))
$(info Source files: $(SRCS))
$(info Object files: $(OBJS))
$(info )

#  cilj ki prevede celoten projekt
all: build/$(TARGET)

# cilj, ki prevede program za razhroscevanje
debug: CXXFLAGS:= -g -O0 $(CXXFLAGS)
debug: all

# cilj, ki prevede program za izdajo
release: CXXFLAGS:= -O3 $(CXXFLAGS)
release: all

# cilj, ki pocisti prevedene zbirke
clean:
	rm -rf build/*

# cilj, ki prevede posamezno izvorno zbirko v objektni modul
build/%.o: src/%.cpp
	$(CXX) $(CXXFLAGS) -c -o $@ $^ 

# cilj, ki poveze objektne module v program
build/$(TARGET): $(OBJS)
	$(CXX) $(CXXFLAGS) -o $@ $^ 

'
	echo "$mkfile" >> "$dir/Makefile"
	
	else
		echo "Error: This directory already exists!"
	fi
}

if [[ "$2" = "-d" ]]; then
	create "$1" "$3"
else
	if [[ "$2" = "-h" || "$1" = "-h" ]]; then
		echo "project_new.sh <project name> [-d <filepath>] [-h]"
		echo "add -d <filepath> to specify where the directory should be created"
		echo "add -h for help"
	else
		create "$1" "./"
	fi
fi
