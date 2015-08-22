#include <assert.h>
#include "list.h"

LinkedList* create_list_from_str(char *str)
{
	LinkedList *list = create_list(str, sizeof(char), 0, NULL);
	
	LinkedList *curItem = list;
	char *cur_data = str + 1;
	while (*cur_data != '\0')
	{
		curItem = insert_after(curItem, create_list(cur_data, sizeof(char), 0, NULL));
		cur_data++;
	}

	return list;
}

int is_equal_to_str(LinkedList *list, char *str)
{
	while (list != NULL && *str != '\0')
	{
		if (*(char*)(list->data) != *str)
		{
			return 0;
		}
		list = next_nth(list, 1);
		str++;
	}

	return 1;
}

void test_helper_function()
{
	static char* const initial = "12345";
	LinkedList *list = create_list_from_str(initial);
	assert(is_equal_to_str(list, initial));
}

int main(int argc, char** argv)
{
	test_helper_function();
	return 0;
}