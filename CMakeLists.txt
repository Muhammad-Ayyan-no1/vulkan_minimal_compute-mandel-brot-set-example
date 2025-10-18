cmake_minimum_required(VERSION 3.10)

# Force MinGW toolchain before project()
set(CMAKE_GENERATOR "MinGW Makefiles" CACHE INTERNAL "" FORCE)
set(CMAKE_C_COMPILER "gcc" CACHE STRING "C compiler" FORCE)
set(CMAKE_CXX_COMPILER "g++" CACHE STRING "C++ compiler" FORCE)

project(vulkan_minimal_compute)

# Find Vulkan package
find_package(Vulkan REQUIRED)

# Set C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# GCC specific flags
add_compile_options(-Wall -Wextra)

# Include directories
include_directories(${Vulkan_INCLUDE_DIRS})

# Define source files
set(SOURCES
    src/main.cpp
    src/lodepng.cpp
)

# Create executable
add_executable(${PROJECT_NAME} ${SOURCES})



# Link libraries
target_link_libraries(${PROJECT_NAME} PRIVATE Vulkan::Vulkan)

# Set working directory for debugging
set_target_properties(${PROJECT_NAME} PROPERTIES 
    RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin
)