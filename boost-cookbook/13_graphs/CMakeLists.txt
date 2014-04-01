project(13_graph)
cmake_minimum_required(VERSION 2.8)

include(CheckCXXCompilerFlag)
check_cxx_compiler_flag("-std=c++11" COMPILER_SUPPORTS_CXX11)
check_cxx_compiler_flag("-std=c++0X" COMPILER_SUPPORTS_CXX0X)

if(COMPILER_SUPPORTS_CXX11)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
elseif(COMPILER_SUPPORTS_CXX0X)
  set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
else()
  message(ERROR "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support.")
endif()

find_package(Boost 1.54 COMPONENTS graph REQUIRED)
include_directories(Boost_INCLUDE_DIR)

file(GLOB CPP_FILES "*.cpp")
foreach(CPP_FILE ${CPP_FILES})
  get_filename_component(FILE_NAME ${CPP_FILE} NAME)
  message(STATUS "Added: " ${FILE_NAME})
  add_executable(${FILE_NAME} ${CPP_FILE})
  target_link_libraries(${FILE_NAME} ${Boost_LIBRARIES})
endforeach()

