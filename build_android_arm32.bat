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

@echo ANDROID_NDK=%ANDROID_NDK%
@echo PROTO_EXECUTABLE=%PROTO_EXECUTABLE%
@echo CMAKE=%CMAKE%

@echo "Current directory is %~dp0"
@cd %~dp0

@set BUILD_DIR=_build_%ABI%

rem @rd /s /q %BUILD_DIR%

@mkdir %BUILD_DIR%

@echo "Build dir is %BUILD_DIR%"
@cd %BUILD_DIR%

@%CMAKE% -G "Unix Makefiles" ^
  -DCMAKE_TOOLCHAIN_FILE=%ANDROID_NDK%\build\cmake\android.toolchain.cmake ^
  -DANDROID_ABI=%ABI% ^
  -DANDROID_NATIVE_API_LEVEL=16 ^
  -DCMAKE_MAKE_PROGRAM=%ANDROID_NDK%\prebuilt\windows-x86_64\bin\make.exe ^
  -DANDROID_STL=c++_static ^
  -DCMAKE_LIBRARY_OUTPUT_DIRECTORY=%~dp0\built\%ABI% ^
  -DCMAKE_RUNTIME_OUTPUT_DIRECTORY=%~dp0\built\%ABI% ^
  ..

@%CMAKE% --build .  -- log-level=DEBUG

@echo cd %%~dp0 >> REBUILD.cmd
@echo %CMAKE% --build . >> REBUILD.cmd
@echo @ping -n 5 127.0.0.1 ^> nul >> REBUILD.cmd
@cd ..

pause