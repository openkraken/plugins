cmake_minimum_required(VERSION 3.2.0)
set(CMAKE_OSX_DEPLOYMENT_TARGET 10.11)
project(KrakenAnimationPlayer)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if ($ENV{KRAKEN_JS_ENGINE} MATCHES "jsc")
    add_compile_options(-DKRAKEN_JSC_ENGINE=1)
    if (${IS_ANDROID})
        list(APPEND BRIDGE_INCLUDE
                ${CMAKE_CURRENT_SOURCE_DIR}/third_party/
                )
        add_library(JavaScriptCore SHARED IMPORTED)
        set_target_properties(JavaScriptCore PROPERTIES IMPORTED_LOCATION
                "${CMAKE_CURRENT_SOURCE_DIR}/kraken/lib/android/jniLibs/${ANDROID_ABI}/libjsc.so"
                )
        list(APPEND BRIDGE_LINK_LIBS
                JavaScriptCore
                )
    else()
        list(APPEND BRIDGE_LINK_LIBS "-framework JavaScriptCore")
    endif()
endif()

if (${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
    add_library(kraken SHARED IMPORTED)
    set_target_properties(kraken PROPERTIES IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/kraken/lib/macos/libkraken_jsc.dylib")
elseif(${CMAKE_SYSTEM_NAME} MATCHES "iOS")
    add_library(kraken SHARED IMPORTED)
    set_target_properties(kraken PROPERTIES IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/kraken/lib/ios/kraken_bridge.framework/kraken_bridge")
elseif(${CMAKE_SYSTEM_NAME} MATCHES "Android")
    add_library(kraken SHARED IMPORTED)
    set_target_properties(kraken PROPERTIES IMPORTED_LOCATION "${CMAKE_CURRENT_SOURCE_DIR}/kraken/lib/android/jniLibs/${ANDROID_ABI}/libkraken_jsc.so")
endif()

add_library(kraken_video_player SHARED
        media_element.cc
        media_element.h
        video_element.cc
        video_element.h
        )
if ($ENV{KRAKEN_JS_ENGINE} MATCHES "jsc")
    set_target_properties(kraken_video_player PROPERTIES OUTPUT_NAME kraken_video_player_jsc)
endif()

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
