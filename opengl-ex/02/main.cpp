#include <stdio.h>

#include <GLTools.h>
#include <GLShaderManager.h>

#include <GL/glut.h>

GLBatch squareBatch;
GLShaderManager shaderManager;

GLfloat vVerts[] = {
    -0.1f, -0.1f, 0.0f,
    -0.1f,  0.1f, 0.0f,
     0.2f,  0.1f, 0.0f,
     0.3f, -0.1f, 0.0f,
    -0.1f,  0.2f, 0.0f,
     0.2f,  0.1f, 0.0f,
     0.1f, -0.2f, 0.0f,
    -0.3f,  0.1f, 0.0f,
     0.3f,  0.1f, 0.0f,
     0.1f, -0.0f, 0.0f
};

GLfloat PointSizes[2];
GLfloat PointStep;

void ChangeSize(int w, int h)
{
    glViewport(0, 0, w, h);
}

void SetupRC()
{
    // Blue background
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    shaderManager.InitializeStockShaders();
    // Load up a triangle

    squareBatch.Begin(GL_TRIANGLE_STRIP, 10);
    squareBatch.CopyVertexData3f(vVerts);
    squareBatch.End();
}

void RenderScene(void){
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT | GL_STENCIL_BUFFER_BIT);

    GLfloat vWhite[] = {1.0f, 1.0f, 1.0f, 0.0f};
    shaderManager.UseStockShader(GLT_SHADER_IDENTITY, vWhite);
    squareBatch.Draw();

    glutSwapBuffers();
}

void AddToVector(GLfloat *vec, GLsizei vecc, GLfloat *valv, GLsizei valc){
    for (int i = 0; i < vecc; ++i){
        for (int j = 0; j < valc; ++j){
            vec[valc*i+j] += valv[j];
        }
    }
}

void SpecialKeys(int key, int x, int y){
    GLfloat stepSize = 0.025f;
    GLfloat delta[] = {0, 0, 0};

    if (key == GLUT_KEY_UP)
        delta[1] = stepSize;
    if (key == GLUT_KEY_DOWN)
        delta[1] = -stepSize;
    if (key == GLUT_KEY_LEFT)
        delta[0] = -stepSize;
    if (key == GLUT_KEY_RIGHT)
        delta[0] = stepSize;

    AddToVector(vVerts, 10, delta, 3);

    if (key == GLUT_KEY_F1){
        GLfloat pointSize;
        glGetFloatv(GL_POINT_SIZE, &pointSize);
        if (++pointSize + PointStep > PointSizes[1])
            pointSize = PointSizes[0];
        glPointSize(pointSize);
        glLineWidth(pointSize);
    }

    squareBatch.Begin(GL_LINES, 10);
    squareBatch.CopyVertexData3f(vVerts);
    squareBatch.End();
    glutPostRedisplay();
}

int main(int argc, char *argv[])
{
    gltSetWorkingDirectory(argv[0]);

    glutInit(&argc, argv);
    glutInitDisplayMode(GLUT_DOUBLE | GLUT_RGBA | GLUT_STENCIL);
    glutInitWindowSize(800, 600);
    glutCreateWindow("Triangle");
    glutReshapeFunc(ChangeSize);
    glutDisplayFunc(RenderScene);
    glutSpecialFunc(SpecialKeys);

    glGetFloatv(GL_POINT_SIZE_RANGE, PointSizes);
    glGetFloatv(GL_POINT_SIZE_GRANULARITY, &PointStep);
    glPointSize(PointSizes[0]);

    GLenum err = glewInit();
    if (GLEW_OK != err) {
        fprintf(stderr,"GLEW Error: %s\n", glewGetErrorString(err));
        return 1;
    }

    SetupRC();

    glutMainLoop();
    return 0;
}

