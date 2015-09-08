#include <iostream>

class Token 
{
	public:
		Token(std::string name)
		{
			this->name = name;
		}

		std::string getName()
		{
			return name;
		}

	private:
		std::string name;
};

int main(int argc, char** argv)
{		
	Token token("Test");
}

