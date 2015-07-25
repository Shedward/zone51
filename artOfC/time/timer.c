#include <stdio.h>
#include <stdlib.h>
#include <time.h>

int main(void) {
	time_t start, end;

	start = time(NULL);
	if (start == (time_t)-1) {
		printf("Time not avalible");
		exit(EXIT_FAILURE);
	}

	getchar();
	end = time(NULL);

	printf("\nTime spend %.2f seconds\n", difftime(end, start));

	return EXIT_SUCCESS;
}

