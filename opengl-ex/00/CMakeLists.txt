cmake_minimum_required(VERSION 2.8)

project(hw_opengl)

find_package(GLUT REQUIRED)
include_directories(${GLUT_INCLUDE_DIRS})
link_directories(${GLUT_LIBRARY_DIRS})
add_definitions(${GLUT_DEFINITIONS})
if (NOT GLUT_FOUND)
	message(ERROR " GLUT not found!")
endif()

find_package(OpenGL REQUIRED)
include_directories(${OpenGL_INCLUDE_DIRS})
link_directories(${OpenGL_LIBRARY_DIRS})
add_definitions(${OpenGL_DEFINITIONS})
if (NOT OPENGL_FOUND)
	message(ERROR " OpenGL not found!")
endif()

add_executable(main main.cpp)

target_link_libraries(main ${OPENGL_LIBRARIES} ${GLUT_LIBRARY})