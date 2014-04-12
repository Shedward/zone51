#import <Foundation/Foundation.h>

BOOL areIntsDifferent (int lhs, int rhs)
{
	if (lhs == rhs) {
		return (NO);
	} else {
		return (YES);
	}
}

NSString *boolString (BOOL yes)
{
	if (yes) {
		return (@"YES");
	} else {
		return (@"NO");
	}
}

void test (int lhs, int rhs)
{
	NSLog (@"are %d and %d different? %@",
		lhs, rhs, boolString(areIntsDifferent(lhs, rhs)));
}

int main(int argc, char const *argv[])
{
	test (5, 5);
	test (1, 2);
	BOOL check = 18;
	NSLog (@"18 is YES? %@", boolString(check == YES));
	NSLog (@"18 is NO? %@", boolString(check == NO));
	return 0;
}