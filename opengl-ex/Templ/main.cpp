#include <iostream>

#include <GLTools.h>
#include <GL/glut.h>

using std::cerr;

GLShaderManager shaderManager;

void Setup() {
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    shaderManager.InitializeStockShaders();
}

void Resize(int h, int w) {
    glViewport(0, 0, h, w);
}

void Show(){
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);

    glutSwapBuffers();
}

void SpecKeyPressed(int key, int x, int y){

}

int main(int argc, char ** argv) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_DEPTH);
    glutInitWindowSize(800, 600);
    int window = glutCreateWindow("Main window");

    GLenum err = glewInit();
    if (GLEW_OK != err) {
        cerr << "Error: " << glewGetErrorString(err) << std::endl;
    }

    glutReshapeFunc(Resize);
    glutDisplayFunc(Show);
    glutSpecialFunc(SpecKeyPressed);

    glutMainLoop();
    return 0;
}

