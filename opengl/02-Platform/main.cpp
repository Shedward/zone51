#include <platform.h>
#include <unistd.h>
#include <math.h>

#include <math.h>

class PlatformTest : public platform {
    void OnRender(GLFWwindow *window) override {
        double currentTime = glfwGetTime() * 10;

        glClearColor(
            (float) sin(currentTime) * 0.5f + 0.5f,
            (float) sin(currentTime + 2.0/3.0 * M_PI) * 0.5f + 0.5f,
            (float) sin(currentTime - 2.0/3.0 * M_PI) * 0.5f + 0.5f,
            1.0f
        );

        glClear(GL_COLOR_BUFFER_BIT);
    }
};

MAIN(PlatformTest)
