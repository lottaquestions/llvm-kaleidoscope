# llvm-kaleidoscope
Source code for "My First Language Frontend with LLVM Tutorial"

## Extra package that was needed to be installed to compile in Ubuntu
sudo apt-get install libc++abi-dev

## To compile the chapter 2 source file:
clang++ -stdlib=libc++ -g -O3 toy.cpp `llvm-config --cxxflags` -o toy.bin
