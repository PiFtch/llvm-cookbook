# llvm command

## clang生成LLVM IR
    clang -emit-llvm -S input.c -o output.ll
## clang用作前端
### -E 预处理器
### 打印AST
    // -cc1指定clang只运行前端
    clang -cc1 test.c -ast-dump

## opt优化pass
    opt -passname input.ll -o output.ll

### 内置优化pass
- mem2reg