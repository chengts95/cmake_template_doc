# build_docs.cmake




find_program(SPHINX_EXECUTABLE sphinx-build)

if(NOT SPHINX_EXECUTABLE)
    message(FATAL_ERROR "Sphinx not found. Please install Sphinx.")
endif()


execute_process(
    COMMAND 
   ${SPHINX_EXECUTABLE} -b html
            "${CMAKE_SOURCE_DIR}/doc/source"
            "${CMAKE_BINARY_DIR}/build/doc/html"
    WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}"
    RESULT_VARIABLE sphinx_result
)

if(NOT sphinx_result EQUAL 0)
    message(FATAL_ERROR "Documentation build failed with error code ${sphinx_result}.")
endif()
