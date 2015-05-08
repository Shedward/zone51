#include <platform.h>
#include <math.h>
#include <stdlib.h>

class Polylines : public platform {
public:
    void OnInit(GLFWwindow*) override {
        glHint(GL_LINE_SMOOTH_HINT, GL_DONT_CARE);
        // glPolygonMode(GL_FRONT_AND_BACK, GL_LINE);
    }

    void OnRender(GLFWwindow*) override {
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
        float time = glfwGetTime();
        glBegin(GL_POLYGON);
        for (float j = 1; j > 0.00001; j /= 1.1) {
            for (int i = 0; i < time; i++) {
                float x = j * cos(time + 2.0 * M_PI * i / time) - 0.05 * getRand();
                float y = j * sin(time + 2.0 * M_PI * i / time) - 0.05 * getRand();
                glColor3f(getRand(), getRand(), getRand());
                glVertex3f(x, y, 0.0f);
            }
        }
        glEnd();
    }

private:
    inline float getRand() {
        float r = (float)rand() / (float)RAND_MAX;
        return r;
    }
};

MAIN(Polylines)
