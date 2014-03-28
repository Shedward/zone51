project(6_c03_move)
cmake_minimum_required(VERSION 2.8)
aux_source_directory(. SRC_LIST)

find_package(Boost 1.53 COMPONENTS program_options REQUIRED)
include_directories(${Boost_INCLUDE_DIR})

add_executable(${PROJECT_NAME} ${SRC_LIST})

target_link_libraries(${PROJECT_NAME} ${Boost_LIBRARIES})

