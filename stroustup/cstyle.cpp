#include <stdio.h>

int main(int argc, char const *argv[])
{
	FILE* f = fopen("cstyle.cpp", "r");
	int i = 0;
	char buff[80];
	while(fgets(buff, 80, f)) {
	    printf("%3d  %s", ++i, buff);
	}
	return fclose(f);
	return 0;
}