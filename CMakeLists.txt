cmake_minimum_required(VERSION 3.14.0)

# MUST be done before call to 'project'
get_cmake_property(vars CACHE_VARIABLES)
foreach(var ${vars})
  get_property(currentHelpString CACHE "${var}" PROPERTY HELPSTRING)
    if("${currentHelpString}" MATCHES "No help, variable specified on the command line." OR "${currentHelpString}" STREQUAL "")
        message("${var} = [${${var}}]  --  ${currentHelpString}") # uncomment to see the variables being processed
        list(APPEND CL_ARGS "-D${var}=${${var}}")
    endif()
endforeach()

project(qmcpacksuperbuild)

include (ExternalProject)

list(APPEND CL_ARGS "-DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>")


include(FetchContent)
FetchContent_Declare(
  qmcpack
  GIT_REPOSITORY https://github.com/QMCPACK/qmcpack.git
  GIT_TAG        v3.11.0
)
# Check if population has already been performed
FetchContent_GetProperties(qmcpack)
if(NOT qmcpack_POPULATED)
  # Fetch the content using previously declared details
  FetchContent_Populate(qmcpack)
endif()


ExternalProject_Add(
  qmcpack-real
  SOURCE_DIR ${qmcpack_SOURCE_DIR}
  INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-real/install
  CMAKE_ARGS "${CL_ARGS};-DQMC_COMPLEX=0"
)

ExternalProject_Add(
  qmcpack-complex
  SOURCE_DIR ${qmcpack_SOURCE_DIR}
  INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-complex/install
  CMAKE_ARGS "${CL_ARGS};-DQMC_COMPLEX=1"
)

enable_testing()

add_test(
    NAME qmcpack-real-test
    COMMAND ${CMAKE_COMMAND} -DTEST_EXECUTABLE=ctest -P ${CMAKE_SOURCE_DIR}/cmake/RunTests.cmake
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/qmcpack-real-prefix/src/qmcpack-real-build
)

add_test(
    NAME qmcpack-complex-test
    COMMAND ${CMAKE_COMMAND} -DTEST_EXECUTABLE=ctest -P ${CMAKE_SOURCE_DIR}/cmake/RunTests.cmake
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}/qmcpack-complex-prefix/src/qmcpack-complex-build
)
