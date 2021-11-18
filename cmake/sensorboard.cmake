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

# convert build type to lower for src folder
string(TOLOWER ${CMAKE_BUILD_TYPE} BUILD_TYPE_LOWER)

ADD_CUSTOM_TARGET("sign"
  COMMAND ${CMAKE_OBJCOPY} -O binary -S ${CMAKE_CURRENT_BINARY_DIR}/${BUILD_TYPE_LOWER}/${CMAKE_PROJECT_NAME}.elf ${CMAKE_PROJECT_NAME}.bin 
  COMMAND ${CMAKE_OBJCOPY} -O ihex -S ${CMAKE_CURRENT_BINARY_DIR}/${BUILD_TYPE_LOWER}/${CMAKE_PROJECT_NAME}.elf ${CMAKE_PROJECT_NAME}.hex 
)