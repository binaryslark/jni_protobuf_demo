@echo off

@set ABI=armeabi-v7a

@if DEFINED NDK_ROOT (
    echo "DEFINED NDK_ROOT: %NDK_ROOT%"
    @set ANDROID_NDK=%NDK_ROOT%
) else (
    @set ANDROID_NDK=D:\tools\android-ndk-r19c-windows-x86_64\android-ndk-r19c
)

@if DEFINED CMAKE (
    @echo "DEFINED CMAKE: %CMAKE%"
) else (
    @set CMAKE=E:\tools\sdk\cmake\3.10.2.4988404\bin\cmake.exe
)

@cd %~dp0
@set BUILD_DIR=_build_%ABI%
@echo "BUILD_DIR=%BUILD_DIR%"


REM @rd /s /q %BUILD_DIR%

@mkdir %BUILD_DIR%

@cd %BUILD_DIR%
@%CMAKE% -G "Unix Makefiles" ^
  -S protobuf-cpp-3.17.3\protobuf-3.17.3\cmake ^
  -DCMAKE_TOOLCHAIN_FILE=%ANDROID_NDK%\build\cmake\android.toolchain.cmake ^
  -DANDROID_ABI=%ABI% ^
  -DANDROID_NATIVE_API_LEVEL=19 ^
  -DCMAKE_MAKE_PROGRAM=%ANDROID_NDK%\prebuilt\windows-x86_64\bin\make.exe ^
  -DANDROID_STL=c++_static ^
  -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=%~dp0\built\%ABI% ^
  -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=%~dp0\built\%ABI% ^
  -DANDROID_LINKER_FLAGS="-landroid -llog" ^
  -Dprotobuf_BUILD_TESTS=OFF ^
  -Dprotobuf_SHARED_OR_STATIC=STATIC ^
  -Dprotobuf_VERBOSE=True ^
  ..
@%CMAKE% --build . --target libprotobuf-lite libprotobuf --config Release -- log-level=DEBUG

@pause