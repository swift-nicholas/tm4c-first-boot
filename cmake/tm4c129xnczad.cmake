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

# Processor specific definitions
add_definitions(-DPART_TM4C129XNCZAD)
# add_definitions(-DTARGET_IS_TM4C129_RA1)
add_definitions(-Dgcc)
add_definitions(-DTARGET_IS_SNOWFLAKE_RA1)

message(STATUS "Adding definitions -DPART_TM4C129XNCZAD -DTARGET_IS_TM4C129_RA1 -DTARGET_IS_SNOWFLAKE_RA1")

# Add linker flags
add_link_options(-T${PROJECT_SOURCE_DIR}/tm4c129xnczad.ld -specs=${PROJECT_SOURCE_DIR}/tm4c129x.specs -Xlinker -Map=output.map)