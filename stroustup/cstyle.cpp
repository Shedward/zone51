#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <stdlib.h>

int print_source() {
	FILE* f = fopen("cstyle.cpp", "r");
	int i = 0;
	char buff[80];
	while(fgets(buff, 80, f)) {
	    printf("%3d  %s", ++i, buff);
	}
	return fclose(f);
}

void strs() {
	char msg[20] = "Hello world";
	printf("\n\n%s\n", msg);
	printf("Size of msg: %d\n", strlen(msg));

	char msg_copy[20];
	strcpy(msg_copy, msg);
	assert(strcmp(msg, msg_copy) == 0);

	printf("Message concat: %s\n", strcat(msg, msg_copy));

	printf("String from first o: %s\n", strchr(msg, 'o'));
	printf("String from last o: %s\n", strrchr(msg, 'o'));
	printf("String from first aouie: %s\n", strpbrk(msg, msg_copy+4));
}

struct Temp {
	int a;
	int b;
	float c;
	Temp* next;
};
void allocs() {
	void* mem = malloc(sizeof(Temp));
	if (mem != nullptr) {
		Temp* val = (Temp*)mem;
		val->a = 1;
		val->b = 2;
		val->c = 1.1;
		val->next = nullptr;

		printf("%d %d %f\n", val->a, val->b, val->c);

		void* val2 = calloc(4, sizeof(Temp));
		Temp* vali = (Temp*)val2;
		for (int i = 0; i < 4; ++i, ++vali) {
			memcpy(mem, vali, sizeof(Temp));
			printf("%d %d %f\n", vali->a, vali->b, vali->c);
		}

		Temp* temp2 = (Temp*)val2;
		for (int i = 0; i < 4; ++i) {
			printf("%d: %d %d %f \n", i, temp2[i].a, temp2[i].b, temp2[i].c);
		}

		free(val2);
		free(val);
	} else {
		printf("Can't malloc mem for Temp\n");
	}
}

int main(int argc, char const *argv[])
{
	print_source();
	strs();
	char msg[] = "101";
	char* tmp = 0;
	printf("%lu\n", strtol("101000011010111010",&tmp,2));
	allocs();
	return 0;
}