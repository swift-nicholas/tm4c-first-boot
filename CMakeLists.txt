#  SWIFT PERFORMANCE EQUIPMENT CONFIDENTIAL
#     _   _                             _
#    /_\ | |_ _ __ ___   ___  ___ _ __ | |__   ___ _ __ ___
#   //_\\| __| '_ ` _ \ / _ \/ __| '_ \| '_ \ / _ \ '__/ _ \
#  /  _  \ |_| | | | | | (_) \__ \ |_) | | | |  __/ | |  __/
#  \_/ \_/\__|_| |_| |_|\___/|___/ .__/|_| |_|\___|_|  \___|
#                               |_|
#     @swift-nicholas <nicholas@swiftperformance.com> 2021
#  __________________
# 
#   Copyright 2021 Swift Performance Equipment
#   All Rights Reserved.
# 
#  NOTICE:  All information contained herein is, and remains
#  the property of Swift Performance Equipment and its suppliers,
#  if any.  The intellectual and technical concepts contained
#  herein are proprietary to Swift Performance Equipment.
#  and its suppliers and may be covered by U.S. and Foreign Patents,
#  patents in process, and are protected by trade secret or copyright law.
#  Dissemination of this information or reproduction of this material
#  is strictly forbidden unless prior written permission is obtained
#  from Swift Performance Equipment.

# CMake configuration
cmake_minimum_required(VERSION 3.16.0)

message(STATUS "CMake version: ${CMAKE_VERSION}")

if(CMAKE_BINARY_DIR STREQUAL CMAKE_SOURCE_DIR)
  message(FATAL_ERROR "In-source builds are not supported. Please use separate folder for build.")
endif()

# configure module path to include cortexm4f.cmake configuration
list(APPEND CMAKE_MODULE_PATH "${CMAKE_CURRENT_SOURCE_DIR}/cmake")
set(CMAKE_SYSTEM_NAME cortexm4f) # import cortexm4f.cmake
set(CMAKE_SYSTEM_PROCESSOR ARM)

# Skip trying to compile test program
set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)
set(CMAKE_ASM_COMPILER_WORKS 1)

# -----------------------------------------------------------------------------
# Project configuration

project(bootloader
        DESCRIPTION "A lightweight bootloader and application launcher for tm4c129x processors"
        VERSION 0.0.1)

message(STATUS "Project: ${CMAKE_PROJECT_NAME}; ${CMAKE_PROJECT_DESCRIPTION} - v${CMAKE_PROJECT_VERSION}")

# configure source directory location
set(xpack_project_folder ${CMAKE_SOURCE_DIR})

message(STATUS "Module paths: ${CMAKE_MODULE_PATH}")

# -----------------------------------------------------------------------------
# Configure compiler

enable_language(C)
enable_language(ASM)

# Preprocessor definitions (Added debug compiler definition)
add_compile_definitions(
  $<$<STREQUAL:"${CMAKE_BUILD_TYPE}","Debug">:DEBUG>
)

message(STATUS "C Compiler: ${CMAKE_C_COMPILER_ID} ${CMAKE_C_COMPILER_VERSION}")
message(STATUS "ASM Compiler: ${CMAKE_ASM_COMPILER_ID} ${CMAKE_ASM_COMPILER_VERSION}")

# Generate the compile_commands.json file to feed the indexer.
# It is recommended to be passed on the command line to make it very clear
# that it is mandatory, but can also be passed here, for just in case.
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

# -----------------------------------------------------------------------------
# Cross compilation and architecture specific

message(STATUS "==> Tiva C")

# variant used 
set(TIVA_VARIANT "tm4c129encpdt" CACHE STRING "Tiva C variant")
message(STATUS "Tiva: Using variant ${TIVA_VARIANT}")

if(TIVA_VARIANT STREQUAL tm4c129encpdt)
  message(STATUS "Including tm4c129encpdt.cmake")
  include(cmake/tm4c129encpdt.cmake)
elseif (TIVA_VARIANT STREQUAL tm4c129xnczad)
  message(STATUS "Including tm4c129xnczad.cmake")
  include(cmake/tm4c129xnczad.cmake)
else()
  message(STATUS "including tm4c129xnczad.cmake")
  include(cmake/tm4c129xnczad.cmake)
endif()

# add sensorboard target commands
include(cmake/sensorboard.cmake)

# -----------------------------------------------------------------------------
# Libraries

# tivaware library
set(TIVAWARE_PATH "$ENV{TIVAWARE}")
message(STATUS "Tivware: ${TIVAWARE_PATH}")

# -----------------------------------------------------------------------------
# Create the application.

add_executable(application)
message(STATUS "==> application")

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "Project path: ${xpack_project_folder}")
message(STATUS "Compiler flags: ${CMAKE_C_FLAGS}")
message(STATUS "Linker flags: ${CMAKE_EXE_LINKER_FLAGS}")

set_target_properties(
  application

  PROPERTIES
    OUTPUT_NAME "${CMAKE_PROJECT_NAME}.elf"
)

# required application sources
set(sources ${xpack_project_folder}/src/${TIVA_VARIANT}_startup_gcc.c
    ${xpack_project_folder}/src/main.c
)

# include required libs
include(cmake/libs.cmake)

message(STATUS "Application sources: ${sources}")

# Application sources.
target_sources(
  application

  PRIVATE
    ${sources}
)

# Application includes.
target_include_directories(
  application

  PRIVATE
    ${xpack_project_folder}/include
    ${TIVAWARE_PATH}
)

# link tivware driver library
target_link_libraries(application
    ${TIVAWARE_PATH}/driverlib/gcc/libdriver.a
)

unset(TIVA_VARIANT CACHE)