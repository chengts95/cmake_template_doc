cmake_minimum_required(VERSION 3.16)

project(unit_test)
enable_testing()

include(FetchContent)
FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/tags/v1.15.0.tar.gz
)

if(WIN32)
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
endif()

FetchContent_MakeAvailable(googletest)

#add_executable(run_tests src/test.cpp )
#target_link_libraries(run_tests GTest::gtest_main fb_protocol flatbuffers::flatbuffers  )
include(GoogleTest)
#gtest_discover_tests(run_tests)