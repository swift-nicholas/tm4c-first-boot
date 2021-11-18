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

message(STATUS "==> cortex-m4f")

# this will prevent cmake from testing the compiler which will fail with no startup code
# (https://stackoverflow.com/questions/53633705/cmake-the-c-compiler-is-not-able-to-compile-a-simple-test-program/53635241) 
set(CMAKE_TRY_COMPILE_TARGET_TYPE "STATIC_LIBRARY")

set(TOOLCHAIN_PREFIX "arm-none-eabi")

# Cross compiler toolchain binary naming
set(CMAKE_C_COMPILER ${TOOLCHAIN_PREFIX}-gcc CACHE STRING "ARM GCC toolchain C compiler.")
set(CMAKE_CXX_COMPILER ${TOOLCHAIN_PREFIX}-g++ CACHE STRING "ARM GCC toolchain C++ compiler.")
set(CMAKE_ASM_COMPILER ${TOOLCHAIN_PREFIX}-as CACHE STRING "ARM GCC toolchain ASM compiler.")
set(CMAKE_AR ${TOOLCHAIN_PREFIX}-ar CACHE STRING "ARM GCC toolchain AR binary.")
set(CMAKE_OBJCOPY ${TOOLCHAIN_PREFIX}-objcopy CACHE STRING "ARM GCC toolchain obj copy binary.")
set(CMAKE_OBJDUMP ${TOOLCHAIN_PREFIX}-objdump CACHE STRING "ARM GCC toolchain obj dump binary.")

set(CPU "-mcpu=cortex-m4" CACHE STRING "ARM CPU family flags.")
set(FPU "-mfpu=fpv4-sp-d16 -mfloat-abi=hard" CACHE STRING "ARM floating point flags.")
set(ARCH "-march=armv7e-m+fp" CACHE STRING "ARM architecutre flags.")

# -----------------------------------------------------------------------------
# C Build configurations 
UNSET(CMAKE_C_FLAGS CACHE)
set(CMAKE_C_FLAGS "${CMAKE_C_FLAGS} -mthumb ${CPU} ${FPU} ${ARCH} -std=gnu99 -ffunction-sections -fdata-sections -MD -Wall -pedantic" 
  CACHE STRING "Common C compiler flags.")

set(CMAKE_C_FLAGS_DEBUG "-O0 -g3" 
  CACHE STRING "Flags used by the C compiler during DEBUG builds.")

set(CMAKE_C_FLAGS_MINSIZEREL "-Os -DNDEBUG" 
  CACHE STRING "Flags used by the C compiler during MINSIZEREL builds.")

set(CMAKE_C_FLAGS_RELEASE "-O3 -DNDEBUG" 
  CACHE STRING "Flags used by the C compiler during RELEASE builds.")

set(CMAKE_C_FLAGS_RELWITHDEBINFO "-O2 -g3 -DNDEBUG" 
  CACHE STRING "Flags used by the C compiler during RELWITHDEBINFO builds.")

message(STATUS "${CMAKE_C_FLAGS}")

# -----------------------------------------------------------------------------
# C++ Build configurations
UNSET(CMAKE_CXX_FLAGS CACHE)
set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -mthumb ${CPU} ${FPU} ${ARCH} -ffunction-sections -fdata-sections -MD -Wall -pedantic -fno-exceptions -fno-rtti"
CACHE STRING "Common C++ compiler flags.")

set(CMAKE_CXX_FLAGS_DEBUG "-O0 -g3" 
CACHE STRING "Flags used by the CXX compiler during DEBUG builds.")

set(CMAKE_CXX_FLAGS_MINSIZEREL "-Os -DNDEBUG" 
CACHE STRING "Flags used by the CXX compiler during MINSIZEREL builds.")

set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG" 
CACHE STRING "Flags used by the CXX compiler during RELEASE builds.")

set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-O2 -g3 -DNDEBUG" 
CACHE STRING "Flags used by the CXX compiler during RELWITHDEBINFO builds.")

# -----------------------------------------------------------------------------
# ASM Build configurations
UNSET(CMAKE_ASM_FLAGS CACHE)
set(CMAKE_ASM_FLAGS "${CMAKE_ASM_FLAGS} -mthumb ${CPU} ${FPU} ${ARCH} -MD"
CACHE STRING "Common asm flags")

set(CMAKE_ASM_FLAGS_DEBUG "-O0 -g3" 
CACHE STRING "Flags used by the ASM compiler during DEBUG builds.")

set(CMAKE_ASM_FLAGS_MINSIZEREL "-Os -DNDEBUG" 
CACHE STRING "Flags used by the ASM compiler during MINSIZEREL builds.")

set(CMAKE_ASM_FLAGS_RELEASE "-O3 -DNDEBUG" 
CACHE STRING "Flags used by the ASM compiler during RELEASE builds.")

set(CMAKE_ASM_FLAGS_RELWITHDEBINFO "-O2 -g3 -DNDEBUG" 
CACHE STRING "Flags used by the ASM compiler during RELWITHDEBINFO builds.")

set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "")
set(CMAKE_SHARED_LIBRARY_LINK_CXX_FLAGS "")

# set compiled output extension
set(CMAKE_ASM_OUTPUT_EXTENSION ".o")
set(CMAKE_C_OUTPUT_EXTENSION ".o")
set(CMAKE_CXX_OUTPUT_EXTENSION ".o")