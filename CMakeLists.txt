cmake_minimum_required(VERSION 3.5.0)
project(physlab2024-comp-qcd VERSION 0.1.0 LANGUAGES C CXX)

include(CTest)
enable_testing()

add_definitions("-Wall -Wextra")
add_executable(physlab2024-comp-qcd src/main.cpp)

set(CPACK_PROJECT_NAME ${PROJECT_NAME})
set(CPACK_PROJECT_VERSION ${PROJECT_VERSION})
include(CPack)
