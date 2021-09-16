cmake_minimum_required(VERSION 3.2.0)
project(kraken_video_player)

set (CMAKE_MODULE_PATH /Users/andycall/work/plugin-build-tools/cmake)
find_package(kraken)

add_library(kraken_video_player SHARED
  .kraken-test-tools/kraken_video_player.cc
.kraken-test-tools/kraken_video_player.h
)

list(APPEND BRIDGE_INCLUDE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(kraken_video_player ${BRIDGE_LINK_LIBS} kraken)
target_include_directories(kraken_video_player PUBLIC ${BRIDGE_INCLUDE})

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
  set_target_properties(kraken_video_player
        PROPERTIES
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../macos"
        )
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Android")
  set_target_properties(kraken_video_player
        PROPERTIES
        LIBRARY_OUTPUT_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}/../android/jniLibs/${ANDROID_ABI}/"
        )
endif()

if (${CMAKE_SYSTEM_NAME} MATCHES "iOS")
  set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGNING_REQUIRED "NO")
  set(CMAKE_XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "")

  set_target_properties(kraken_video_player PROPERTIES
          OUTPUT_NAME kraken_video_player
          FRAMEWORK TRUE
          FRAMEWORK_VERSION C
          MACOSX_FRAMEWORK_IDENTIFIER com.openkraken.plugins.kraken_video_player
          )
endif()
  