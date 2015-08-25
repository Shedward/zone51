#include <assert.h>
#include <stdio.h>
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

int is_list_eq_str(LinkedList *list, char *str)
{
	while (1)
	{
		if (list == NULL && *str == '\0')
		{
			return 1;
		}

		if (list == NULL ^ *str == '\0')
		{
			return 0;
		}

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
	static char* const not_equal = "123";
	static char* const non_equal2 = "321";

	LinkedList *list = create_list_from_str(initial);

	assert(is_list_eq_str(list, initial));
	assert(!is_list_eq_str(list, not_equal));
	assert(!is_list_eq_str(list, non_equal2));

	destroy_list(list);
}

void test_insert_remove()
{
	static char* const a = "hello ";
	static char* const b = "world";
	static char* const ab = "hello world";
	static char* const c = "hellworldo ";

	LinkedList *ab_list = create_list_from_str(a);
	LinkedList *b_list = create_list_from_str(b);

	insert_after(last_item(ab_list), b_list);

	assert(is_list_eq_str(ab_list, ab));

	destroy_list(ab_list);
	destroy_list(b_list);

	LinkedList *c_list = create_list_from_str(a);
	LinkedList *b2_list = create_list_from_str(b);
	
	insert_after(next_nth(c_list, 3), b2_list);

	assert(is_list_eq_str(c_list, c));

	destroy_list(c_list);
	destroy_list(b2_list);
}

void test_last_and_nth_item()
{
	static char* const x = "1234";

	LinkedList *x_list = create_list_from_str(x);

	LinkedList *third = next_nth(x_list, 2);
	assert(*(char*)third->data == '3');

	LinkedList *last = last_item(x_list);
	assert(*(char*)last->data == '4');

	LinkedList *next_to_last = next_nth(last, 1);
	assert(next_to_last == NULL);

	destroy_list(x_list);
}

int main(int argc, char** argv)
{
	test_last_and_nth_item();
	test_helper_function();
	test_insert_remove();
	return 0;
}