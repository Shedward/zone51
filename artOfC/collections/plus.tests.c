#include <assert.h>
#include "plus.h"

int main()
{
	assert(plus(1, 1) == 2);
	assert(plus(-1, 1) == 0);
}