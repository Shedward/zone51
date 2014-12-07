#include <cstddef>
#include <iostream>

class Base {
public:
    void x() { doStuff("(void)"); }
    virtual void x(int) { doStuff("(int)"); }
    void x(std::string) { doStuff("(string)"); }

protected:
    void doStuff(std::string x) {
        std::cout << "Stuff: " << x << std::endl;
    }
};

class Child : public Base {
public:
    void x() { doStuff("[c] (void)"); }

    void x(int) override {
        doStuff("[c] (int)");
    }
};

int main() {
    Base base;
    base.x();
    base.x(2);
    base.x("Hello");

    std::cout << std::endl;

    Child child;
    child.x();
    child.x(2);
    // child.x("Hello");

    std::cout << std::endl;

    base = child;
    base.x();
    base.x(2);
    base.x("Hello");

    std::cout << std::endl;

    Base& base2 = child;
    base2.x();
    base2.x(2);
    base2.x("Hello");
}
