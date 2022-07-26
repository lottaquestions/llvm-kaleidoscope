# llvm-kaleidoscope
Source code for "My First Language Frontend with LLVM Tutorial"

## Extra package that was needed to be installed to compile in Ubuntu
sudo apt-get install libc++abi-dev

## To compile the chapter 2 source file:
clang++ -stdlib=libc++ -g -O3 toy.cpp `llvm-config --cxxflags` -o toy.bin


 ## Chapter 2 tests to run in the kaliedoscop REPL:
 ~/work/compiler_design/Kaleidoscope$ ./toy.bin 
 ready> def foo(x y) x+foo(y, 4.0);
 ready> Parsed a function definition.
 ready> def foo(x y) x+y y;
 ready> Parsed a function definition.
 ready> Parsed a top-level expression.
 ready> def foo(x y) x+y );
 ready> Parsed a function definition.
 ready> Error: unknown token when expecting an expression
 ready> extern sin(a);
 ready> Parsed an extern.
 ready> 
