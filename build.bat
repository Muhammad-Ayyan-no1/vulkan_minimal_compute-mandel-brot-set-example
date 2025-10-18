@echo off
setlocal EnableDelayedExpansion

REM Clean build directory if it exists
if exist build (
    rmdir /s /q build
)

REM Create fresh build directory
mkdir build
if errorlevel 1 (
    echo Failed to create build directory
    pause
    exit /b 1
)

REM Generate build files with CMake using MinGW generator
cd build
cmake -G "MinGW Makefiles" ..
if errorlevel 1 (
    echo CMake generation failed
    cd ..
    pause
    exit /b 1
)

REM Build the project
mingw32-make
if errorlevel 1 (
    echo Build failed
    pause
    exit /b 1
)

REM Create bin directory if it doesn't exist
if not exist bin mkdir bin

REM Copy assets folder to build/bin if it exists
if exist ..\assets (
    echo Copying assets folder...
    powershell -Command "Copy-Item -Path '..\assets' -Destination '.\bin\assets' -Recurse -Force"
)

REM Run the executable
cd bin
echo === Program Started ===
vulkan_minimal_compute.exe
if errorlevel 1 (
    echo Program execution failed
)

echo.
echo Press any key to continue...
pause >nul