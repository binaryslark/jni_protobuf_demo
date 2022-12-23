# jni_protobuf_demo
JNI下cmake编译protobuf的demo示例

- protobuf version: v3.17.3
- [protocolbuffers/protobuf/releases/tag/v3.17.3](https://github.com/protocolbuffers/protobuf/releases/tag/v3.17.3)
- 下载protoc-3.17.3-win64.zip, 使用`protoc.exe`编译`.proto`文件, 生成`.pb.h`, .`pb.cc`文件
- 下载protobuf-cpp-3.17.3.zip, 用于编译生成静态库`libprotobuf.a`, `libprotobuf-lite.a`

# 编译静态库
- 下载protobuf-cpp-3.17.3.zip并解压
- 执行build_protobuf.bat, 开始编译
    - 须指定`NDK_ROOT`, `CMAKE`
    - CMAKE `-S`参数须指定正确的protobuf的cmake目录
```
"BUILD_DIR=_build_armeabi-v7a"
-- Protocol Buffers Configuring...
-- protobuf_BUILD_TESTS:OFF
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: E:/tools/android-ndk-r19c-windows-x86_64/android-ndk-r19c/toolchains/llvm/prebuilt/windows-x86_64/bin/clang.exe - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: E:/tools/android-ndk-r19c-windows-x86_64/android-ndk-r19c/toolchains/llvm/prebuilt/windows-x86_64/bin/clang++.exe - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
--
-- 3.17.3.0
-- Configuration script parsing status [
--   Description : Protocol Buffers
--   Version     : 3.17.3.0 (3.17.3)
--   Contact     : protobuf@googlegroups.com
-- ]
-- Looking for pthread.h
-- Looking for pthread.h - found
-- Performing Test CMAKE_HAVE_LIBC_PTHREAD
-- Performing Test CMAKE_HAVE_LIBC_PTHREAD - Failed
-- Looking for pthread_create in pthreads
-- Looking for pthread_create in pthreads - not found
-- Looking for pthread_create in pthread
-- Looking for pthread_create in pthread - not found
-- Check if compiler accepts -pthread
-- Check if compiler accepts -pthread - yes
-- Found Threads: TRUE
-- Found ZLIB: E:/tools/android-ndk-r19c-windows-x86_64/android-ndk-r19c/toolchains/llvm/prebuilt/windows-x86_64/sysroot/usr/lib/arm-linux-androideabi/libz.a (found version "1.2.7")
-- Performing Test protobuf_HAVE_BUILTIN_ATOMICS
-- Performing Test protobuf_HAVE_BUILTIN_ATOMICS - Success
-- protobuf_SHARED_OR_STATIC:STATIC
-- Protocol Buffers Configuring done
-- Configuring done
-- Generating done
-- Build files have been written to: E:/Discovery/protobuf/_build_armeabi-v7a
Scanning dependencies of target libprotobuf-lite
[  6%] Building CXX object CMakeFiles/libprotobuf-lite.dir/E_/Discovery/protobuf/protobuf-cpp-3.17.3/protobuf-3.17.3/src/google/protobuf/any_lite.cc.o
[  6%] Building CXX object CMakeFiles/libprotobuf-lite.dir/E_/Discovery/protobuf/protobuf-cpp-3.17.3/protobuf-3.17.3/src/google/protobuf/arena.cc.o
...
[ 93%] Building CXX object CMakeFiles/libprotobuf-lite.dir/E_/Discovery/protobuf/protobuf-cpp-3.17.3/protobuf-3.17.3/src/google/protobuf/wire_format_lite.cc.o
[100%] Linking CXX static library libprotobuf-lite.a
[100%] Built target libprotobuf-lite
Scanning dependencies of target libprotobuf
[  0%] Building CXX object CMakeFiles/libprotobuf.dir/E_/Discovery/protobuf/protobuf-cpp-3.17.3/protobuf-3.17.3/src/google/protobuf/any_lite.cc.o
[  2%] Building CXX object CMakeFiles/libprotobuf.dir/E_/Discovery/protobuf/protobuf-cpp-3.17.3/protobuf-3.17.3/src/google/
...
[ 97%] Building CXX object CMakeFiles/libprotobuf.dir/E_/Discovery/protobuf/protobuf-cpp-3.17.3/protobuf-3.17.3/src/google/protobuf/wire_format.cc.o
[100%] Building CXX object CMakeFiles/libprotobuf.dir/E_/Discovery/protobuf/protobuf-cpp-3.17.3/protobuf-3.17.3/src/google/protobuf/wrappers.pb.cc.o
[100%] Linking CXX static library libprotobuf.a
[100%] Built target libprotobuf
请按任意键继续. . .
```
编译完成后，将静态库和头文件放入`3rdparty/protobuf/`目录，机构如下
- 3rdparty
    - protobuf
        - armeabi-v7a
            - libprotobuf.a
        - include
            - google
                - protobuf
                    - ...

# 编译demo
- 使用protoc.exe编译`tutorial.proto`, 生成`tutorial.pb.h`, `tutorial.pb.cc`
- 执行build_android_arm32.bat, 开始编译
```
"DEFINED NDK_ROOT: E:\tools\android-ndk-r19c-windows-x86_64\android-ndk-r19c"
"DEFINED CMAKE: E:\tools\sdk\cmake\3.18.1\bin\cmake.exe"
ANDROID_NDK=E:\tools\android-ndk-r19c-windows-x86_64\android-ndk-r19c
PROTO_EXECUTABLE=
CMAKE=E:\tools\sdk\cmake\3.18.1\bin\cmake.exe
"Current directory is E:\Projects\jni_protobuf_demo\"
"Build dir is _build_armeabi-v7a"
-- Detecting C compiler ABI info
-- Detecting C compiler ABI info - done
-- Check for working C compiler: E:/tools/android-ndk-r19c-windows-x86_64/android-ndk-r19c/toolchains/llvm/prebuilt/windows-x86_64/bin/clang.exe - skipped
-- Detecting C compile features
-- Detecting C compile features - done
-- Detecting CXX compiler ABI info
-- Detecting CXX compiler ABI info - done
-- Check for working CXX compiler: E:/tools/android-ndk-r19c-windows-x86_64/android-ndk-r19c/toolchains/llvm/prebuilt/windows-x86_64/bin/clang++.exe - skipped
-- Detecting CXX compile features
-- Detecting CXX compile features - done
CMAKE_CURRENT_SOURCE_DIR is E:/Projects/jni_protobuf_demo
-- THIRD_PARTY_DIR=E:/Projects/jni_protobuf_demo/3rdparty
-- libprotobuf-lite path is E:/Projects/jni_protobuf_demo/3rdparty/protobuf/armeabi-v7a/libprotobuf-lite.a
-- libprotobuf path is E:/Projects/jni_protobuf_demo/3rdparty/protobuf/armeabi-v7a/libprotobuf.a
-- Add include directory:E:/Projects/jni_protobuf_demo/3rdparty/protobuf/include
-- Add include directory:E:/Projects/jni_protobuf_demo
-- Configuring done
-- Generating done
-- Build files have been written to: E:/Projects/jni_protobuf_demo/_build_armeabi-v7a
Scanning dependencies of target demo
[ 33%] Building CXX object CMakeFiles/demo.dir/source/main.cpp.o
[ 66%] Building CXX object CMakeFiles/demo.dir/source/proto/tutorial.pb.cc.o
[100%] Linking CXX executable ../built/armeabi-v7a/demo
[100%] Built target demo
请按任意键继续. . .
```

## protobuf-lite链接失败
编译`demo`时，发现链接`protobuf-lite`时失败，但链接`protobuf`成功。