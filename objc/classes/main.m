#include <Person.h>

int main(int argc, char const *argv[])
{
	Person *p = [[Person alloc] init];
	[p setFirstName: "Person"];
	[p sayHelloTo:@"Vlad"];
	return 0;
}