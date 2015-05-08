#ifndef PLATFORM_H
#define PLATFORM_H

#include <GL/glew.h>
#include <GLFW/glfw3.h>

class platform
{
public:
    platform();
    void run();
    virtual void OnInit(GLFWwindow* window) { }
    virtual void OnRender(GLFWwindow* window) = 0;
};

#endif // PLATFORM_H

#define MAIN(app) \
int main() {\
    app application; \
    application.run(); \
    return 0; \
}
