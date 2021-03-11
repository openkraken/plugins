cmake_minimum_required(VERSION 3.2.0)
project(kraken_animation_player)

set (CMAKE_MODULE_PATH /usr/local/lib/node_modules/kraken-npbt/cmake)
find_package(kraken)

add_library(kraken_animation_player SHARED
  animation_player_element.cc
animation_player_element.h
)

if ($ENV{KRAKEN_JS_ENGINE} MATCHES "jsc")
  set_target_properties(kraken_animation_player PROPERTIES OUTPUT_NAME kraken_animation_player_jsc)
endif()

list(APPEND BRIDGE_INCLUDE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(kraken_animation_player ${BRIDGE_LINK_LIBS} kraken)
target_include_directories(kraken_animation_player PUBLIC ${BRIDGE_INCLUDE})

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  set_target_properties(kraken_animation_player
        PROPERTIES
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../macos"
        )
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Android")
  set_target_properties(kraken_animation_player
        PROPERTIES
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../android/jniLibs/${ANDROID_ABI}/"
        )
endif()
  