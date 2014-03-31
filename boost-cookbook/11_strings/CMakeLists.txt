project(11_strings)
cmake_minimum_required(VERSION 2.8)
aux_source_directory(. SRC_LIST)

include(CheckCXXCompilerFlag)
CHECK_CXX_COMPILER_FLAG("-std=c++11" COMPILER_SUPPORTS_CXX11)
CHECK_CXX_COMPILER_FLAG("-std=c++0x" COMPILER_SUPPORTS_CXX0X)
if(COMPILER_SUPPORTS_CXX11)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11")
elseif(COMPILER_SUPPORTS_CXX0X)
        set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++0x")
else()
        message(STATUS "The compiler ${CMAKE_CXX_COMPILER} has no C++11 support. Please use a different C++ compiler.")
endif()

find_package(Boost 1.53 COMPONENTS regex program_options REQUIRED)
include_directories(${Boost_INCLUDE_DIR})

file(GLOB CPP_FILES "*.cpp")

foreach(CPP_FILE ${CPP_FILES})
  get_filename_component(BASE ${CPP_FILE} NAME)
  message(STATUS "Added: " ${BASE} " " ${CPP_FILE})
  add_executable(${BASE} ${CPP_FILE})
  target_link_libraries(${BASE} ${Boost_LIBRARIES} pthread)
endforeach()



