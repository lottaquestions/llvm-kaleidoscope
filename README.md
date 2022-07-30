# llvm-kaleidoscope
Source code for "My First Language Frontend with LLVM Tutorial"

## Extra package that was needed to be installed to compile in Ubuntu
sudo apt-get install libc++abi-dev

## To compile the chapter 2 source file:
clang++ -stdlib=libc++ -g -O3 toy.cpp `llvm-config --cxxflags` -o toy.bin


 ## Chapter 2 tests to run in the kaliedoscope REPL:
 <verbatim>
 ~/work/compiler_design/Kaleidoscope$ ./toy.bin <br />
 ready> def foo(x y) x+foo(y, 4.0); <br />
 ready> Parsed a function definition. <br />
 ready> def foo(x y) x+y y; <br />
 ready> Parsed a function definition. <br />
 ready> Parsed a top-level expression. <br />
 ready> def foo(x y) x+y ); <br />
 ready> Parsed a function definition. <br />
 ready> Error: unknown token when expecting an expression <br />
 ready> extern sin(a); <br />
 ready> Parsed an extern. <br />
 ready> <br />
 </verbatim>
