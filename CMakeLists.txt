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

ExternalProject_Add(
  qmcpack-real
  GIT_REPOSITORY https://github.com/QMCPACK/qmcpack.git
  GIT_TAG v3.11.0
  DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-real/download
  SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-real/source
  INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-real/install
  CMAKE_ARGS "${CL_ARGS};-DQMC_COMPLEX=0"
)

ExternalProject_Add(
  qmcpack-complex
  GIT_REPOSITORY https://github.com/QMCPACK/qmcpack.git
  GIT_TAG v3.11.0
  DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-complex/download
  SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-complex/source
  INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-complex/install
  CMAKE_ARGS "${CL_ARGS};-DQMC_COMPLEX=1"
)
