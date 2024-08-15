# GetGitVersion.cmake
# Function to get the latest Git tag or fallback to commit hash, and check for uncommitted changes

function(get_git_version FULL_VERSION_VAR)
    # Try to get the latest Git tag
    execute_process(
        COMMAND git describe --tags --abbrev=0
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        OUTPUT_VARIABLE GIT_TAG
        ERROR_VARIABLE GIT_ERROR
        RESULT_VARIABLE GIT_RESULT
        OUTPUT_STRIP_TRAILING_WHITESPACE
    )

    if(GIT_RESULT EQUAL 0)
        set(VERSION_STRING "${GIT_TAG}")
    else()
        # Fallback to commit hash if no tag is found or Git is not available
        execute_process(
            COMMAND git rev-parse --short HEAD
            WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
            OUTPUT_VARIABLE GIT_COMMIT_HASH
            ERROR_VARIABLE GIT_ERROR
            RESULT_VARIABLE GIT_RESULT
            OUTPUT_STRIP_TRAILING_WHITESPACE
        )

        if(GIT_RESULT EQUAL 0)
            set(VERSION_STRING "${PROJECT_VERSION}-${GIT_COMMIT_HASH}")
        else()
            set(VERSION_STRING "${PROJECT_VERSION}-unknown")
            message(WARNING "Git is not available or no tags/commits found. Using default version string '${PROJECT_VERSION}-unknown'.")
        endif()
    endif()

    # Check for uncommitted changes
    execute_process(
        COMMAND git diff --quiet
        WORKING_DIRECTORY ${CMAKE_SOURCE_DIR}
        RESULT_VARIABLE GIT_DIFF_RESULT
    )

    if(GIT_DIFF_RESULT EQUAL 0)
        set(GIT_STATUS "")
    else()
        set(GIT_STATUS "-dirty")  # Mark the version as dirty if there are uncommitted changes
    endif()

    # Combine the version string with the status
    set(FULL_VERSION "${VERSION_STRING}${GIT_STATUS}")

    # Set the combined version string in the calling scope
    set(${FULL_VERSION_VAR} "${FULL_VERSION}" PARENT_SCOPE)
endfunction()