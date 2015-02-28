#include <GLTools.h>

#include <GL/glut.h>

void RenderScene() {
    glClear(GL_COLOR_BUFFER_BIT);
    glFlush();
}

void SetupRC() {
    glClearColor(0.0f, 0.0f, 1.0f, 1.0f);
}

int main(int argc, char* argv[]) {
    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_SINGLE | GLUT_RGBA);
    glutCreateWindow("Hello world!");
    glutDisplayFunc(RenderScene);
    SetupRC();
    glutMainLoop();
    return 0;
}
