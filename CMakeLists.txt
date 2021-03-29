cmake_minimum_required(VERSION 3.12.0)

project(qmcpacksuperbuild)

include (ExternalProject)

ExternalProject_Add(
  qmcpack-real
  GIT_REPOSITORY https://github.com/QMCPACK/qmcpack.git
  GIT_TAG v3.10.0
  DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-real/download
  SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-real/source
  #INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-real/install
  CMAKE_ARGS
    -DCMAKE_C_COMPILER=mpicc
    -DCMAKE_CXX_COMPILER=mpicxx
    -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/qmcpack-real/install
    -DQMC_COMPLEX=0
)

ExternalProject_Add(
  qmcpack-complex
  GIT_REPOSITORY https://github.com/QMCPACK/qmcpack.git
  GIT_TAG v3.10.0
  DOWNLOAD_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-complex/download
  SOURCE_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-complex/source
  #INSTALL_DIR ${CMAKE_CURRENT_BINARY_DIR}/qmcpack-complex/install
  CMAKE_ARGS 
    -DCMAKE_C_COMPILER=mpicc
    -DCMAKE_CXX_COMPILER=mpicxx
    -DCMAKE_INSTALL_PREFIX=${CMAKE_CURRENT_BINARY_DIR}/qmcpack-complex/install
    -DQMC_COMPLEX=1
)
