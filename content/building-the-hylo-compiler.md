---
title: Building the Hylo Compiler
date: 2025-02-12T10:23:00-0800
tags:
  - hylo
---
1. Clone [Hylo Git repo](https://github.com/hylo-lang/hylo)
2. Make sure Docker is running
3. `devcontainer up --workspace-folder .{:bash}`
4. Emacs tramp: `docker:<CONTAINER_NAME>:/workspaces/hylo-lang`

``` bash
# Configure
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 -G Ninja
cmake -D CMAKE_BUILD_TYPE=Debug \
	-DBUILD_TESTING=1 -DLLVM_DIR=/opt/llvm-MinSizeRel/lib/cmake/llvm \
	-G Ninja -S . -B Debug
# Build
cmake --build Debug
# Test
ctest --parallel --test-dir Debug
ctest --parallel --test-dir Debug -R "HyloTests"
ctest --parallel --test-dir Debug --rerun-failed --output-on-failure

# Run
./Debug/Sources/hc -v playground/Hello.hylo
./Debug/Sources/hc -v playground/Hello.hylo --typecheck
# Dump AST as pretty json
./Debug/Sources/hc -v playground/Hello.hylo \
	--emit raw-ast -o playground/Hello.ast.tmp \
	&& python3 -m json.tool playground/Hello.ast.tmp > playground/Hello.ast \
	&& rm playground/Hello.ast.tmp
```
