cmake_minimum_required(VERSION 3.16.0)

project(test VERSION 0.1.0  LANGUAGES C CXX)

option(BUILD_TESTS "Enable google test" ON)
option(BUILD_DOC "Enable doxygen+sphinx doc build" OFF)
SET(CMAKE_INSTALL_PREFIX ${CMAKE_CURRENT_SOURCE_DIR} CACHE PATH "${CMAKE_CURRENT_SOURCE_DIR}" FORCE)

include(CheckCXXCompilerFlag)

CHECK_CXX_COMPILER_FLAG("-march=native" COMPILER_SUPPORTS_MARCH_NATIVE)
if(COMPILER_SUPPORTS_MARCH_NATIVE)
    set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -march=native")
endif()
include(cmake/AutoGitVersion.cmake)

# Call the function to get the version
get_git_version(GIT_VERSION)

# Print the version (for debugging purposes)
message(STATUS "Project: ${PROJECT_NAME} Git version: ${GIT_VERSION}")

File( GLOB source_files ${PROJECT_SOURCE_DIR}/src/*.cpp )


add_executable(test   ${source_files})

target_include_directories(
    test
    PUBLIC
    ${PROJECT_SOURCE_DIR}/include/
 )
target_link_libraries(test PRIVATE)
install (TARGETS test DESTINATION bin)


if(BUILD_TESTS)
    add_subdirectory(tests)
endif()

if(BUILD_DOC)


    add_custom_target(Documentation ALL
        COMMAND ${CMAKE_COMMAND} -E env DOC_VERSION=${GIT_VERSION} ${CMAKE_COMMAND} -P "${CMAKE_SOURCE_DIR}/cmake/builddoc.cmake"
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        COMMENT "Generating documentation with Sphinx"
    )

endif()