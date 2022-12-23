
# For more information about using CMake with Android Studio, read the
# documentation: https://d.android.com/studio/projects/add-native-code.html

# Sets the minimum version of CMake required to build the native library.

cmake_minimum_required(VERSION 3.4)

# Declares and names the project.

project("demo")

message("CMAKE_CURRENT_SOURCE_DIR is " ${CMAKE_CURRENT_SOURCE_DIR})

# Searches for a specified prebuilt library and stores the path as a
# variable. Because CMake includes system libraries in the search path by
# default, you only need to specify the name of the public NDK library
# you want to add. CMake verifies that the library exists before
# completing its build.

find_library( # Sets the name of the path variable.
              log-lib

              # Specifies the name of the NDK library that
              # you want CMake to locate.
              log )


# # 以导入外部库的方式(不会重新编译)重新构建一个静态库
# add_library(libprotobuf_static STATIC IMPORTED)
# # 设置要导入的外部静态库的路径
# set_target_properties(libprotobuf_static PROPERTIES IMPORTED_LOCATION ${THIRD_PARTY_DIR}/protobuf/${ANDROID_ABI}/libprotobuf.a)
set(THIRD_PARTY_DIR ${CMAKE_CURRENT_SOURCE_DIR}/3rdparty)
message(STATUS "THIRD_PARTY_DIR=" ${THIRD_PARTY_DIR})
add_library(protobuf-lite STATIC IMPORTED)
set_target_properties(protobuf-lite PROPERTIES IMPORTED_LOCATION ${THIRD_PARTY_DIR}/protobuf/${ANDROID_ABI}/libprotobuf-lite.a)
message(STATUS "libprotobuf-lite path is " ${THIRD_PARTY_DIR}/protobuf/${ANDROID_ABI}/libprotobuf-lite.a)

add_library(protobuf STATIC IMPORTED)
set_target_properties(protobuf PROPERTIES IMPORTED_LOCATION ${THIRD_PARTY_DIR}/protobuf/${ANDROID_ABI}/libprotobuf.a)
message(STATUS "libprotobuf path is " ${THIRD_PARTY_DIR}/protobuf/${ANDROID_ABI}/libprotobuf.a)

# Specifies libraries CMake should link to your target library. You
# can link multiple libraries, such as libraries you define in this
# build script, prebuilt third-party libraries, or system libraries.

add_executable(
                demo

                source/main.cpp
                source/proto/tutorial.pb.cc)    


message(STATUS "Add include directory:" ${THIRD_PARTY_DIR}/protobuf/include)
message(STATUS "Add include directory:" ${CMAKE_CURRENT_SOURCE_DIR})
target_include_directories(demo PRIVATE ${THIRD_PARTY_DIR}/protobuf/include)
target_include_directories(demo PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/source)
target_link_libraries( # Specifies the target library.
                       demo

                       # Links the target library to the log library
                       # included in the NDK.
                       ${log-lib}
                       protobuf # TODO: 使用protobuf-lite会链接失败
                       )