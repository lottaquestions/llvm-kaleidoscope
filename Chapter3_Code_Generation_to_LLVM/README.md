# llvm-kaleidoscope
Source code for "My First Language Frontend with LLVM Tutorial"

## Extra package that was needed to be installed to compile in Ubuntu
sudo apt-get install libc++abi-dev

## To compile the chapter 3 source file:
clang++ -stdlib=libc++ -g3 -D_GLIBCXX_USE_CXX11_ABI=0 toy.cpp `llvm-config --cxxflags --ldflags --system-libs --libs core` -o toy.bin


 ## Chapter 3 tests to run in the kaliedoscop REPL:
 toy crashes because LLVM cannot seem to read member variables of objects encapsulated in a smart pointer.
 
 <verbatim>
 
 ~/work/compiler_design/Kaleidoscope/Chapter3_Code_Generation_to_LLVM$ ./toy.bin <br />
ready> 4+5;<br />
ready> LLVM ERROR: out of memory <br />
Aborted (core dumped) <br />
 </verbatim>
 GDB output shows that it could not access the memory location of the Name member of the PrototypeAST
 class instance.
 
  <verbatim>
Program received signal SIGABRT, Aborted. <br />
__GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50 <br />
50	../sysdeps/unix/sysv/linux/raise.c: No such file or directory. <br />
(gdb) bt <br />
#0  __GI_raise (sig=sig@entry=6) at ../sysdeps/unix/sysv/linux/raise.c:50 <br />
#1  0x00007f7ee5923859 in __GI_abort () at abort.c:79 <br />
#2  0x00007f7ee6637c33 in llvm::report_bad_alloc_error(char const*, bool) () from /lib/x86_64-linux-gnu/libLLVM-10.so.1 <br />
#3  0x00007f7ee6821c4c in llvm::Value::setNameImpl(llvm::Twine const&) () from /lib/x86_64-linux-gnu/libLLVM-10.so.1 <br />
#4  0x00007f7ee6821dc9 in llvm::Value::setName(llvm::Twine const&) () from /lib/x86_64-linux-gnu/libLLVM-10.so.1 <br />
#5  0x00007f7ee67a7dab in llvm::Function::Function(llvm::FunctionType*, llvm::GlobalValue::LinkageTypes, unsigned int, llvm::Twine const&, llvm::Module*) () from /lib/x86_64-linux-gnu/libLLVM-10.so.1 <br />
#6  0x0000000000413ec1 in llvm::Function::Create (Ty=0x1d78070, Linkage=llvm::GlobalValue::ExternalLinkage, N=..., M=0x1d77a00) at /usr/lib/llvm-10/include/llvm/IR/Function.h:144 <br />
#7  0x00000000004088c2 in (anonymous namespace)::PrototypeAST::codegen (this=0x1d77e00) at toy.cpp:471 <br />
#8  0x00000000004042ba in (anonymous namespace)::FunctionAST::codegen (this=0x1d77e40) at toy.cpp:486 <br />
#9  0x0000000000404058 in HandleTopLevelExpression () at toy.cpp:559 <br />
#10 0x0000000000403ad5 in MainLoop () at toy.cpp:591 <br />
#11 0x0000000000403911 in main () at toy.cpp:618 <br />
(gdb) frame 9 <br />
#9  0x0000000000404058 in HandleTopLevelExpression () at toy.cpp:559 <br />
559	    if (auto *FnIR = FnAST->codegen()){ <br />
(gdb) frame 7 <br />
#7  0x00000000004088c2 in (anonymous namespace)::PrototypeAST::codegen (this=0x1d77e00) at toy.cpp:471 <br />
471	  Function *F = Function::Create(FT, Function::ExternalLinkage, Name, TheModule.get()); <br />
(gdb) p Name <br />
$1 = <incomplete type> <br />
(gdb) ptype Name <br />
type = class std::__1::basic_string<char, std::__1::char_traits<char>, std::__1::allocator<char> > { <br />
    <incomplete type> <br />
} <br />
 </verbatim>
