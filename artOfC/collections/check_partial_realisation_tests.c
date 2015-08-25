#include <assert.h>

#include "checking_part_a.h"
#include "checking_part_b.h"

int main() 
{
	assert(return_a() == 'a');
	assert(return_b() == 'b');

	return 0;
}