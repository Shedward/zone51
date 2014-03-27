#include <stdio.h>

int main(int argc, char const *argv[])
{
	int n;
	scanf("%i", &n);

	int cur;
	for (int i = 1; i <= n; ++i) {
		cur = i;
		do {
			printf("%i ", cur);
			if (cur % n == 0) {
				cur += 1;
			} else {
				cur += n + 1;
			}
		} while (cur <= n*n);
		printf("\n");
	}
	return 0;
}