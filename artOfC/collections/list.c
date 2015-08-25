#include "list.h"

#include <assert.h>
#include <memory.h>

LinkedList* create_list(void* data, size_t size, int tag, LinkedListResult *result)
{
	LinkedList* item = malloc(sizeof(*item));
	LinkedListResult res;

	if (item)
	{
		res = LR_SUCCESS;

		item->tag = tag;
		item->size = size;
		item->data = NULL;
		item->ref_count = 0;
		item->next = NULL;

		if (data && size > 0)
		{
			item->data = malloc(size);

			if (item->data)
			{
				res = LR_SUCCESS;

				memcpy(item->data, data, size);
			}
			else 
			{
				res = LR_NO_MEM;
			}
		}
	}
	else 
	{
		res = LR_NO_MEM;
	}

	if (result) { *result = res; }
	return item;
}

void destroy_list(LinkedList* item)
{
	while (item && item->ref_count == 0)
	{
		if (item->data)
		{
			free(item->data);
		}

		LinkedList *item_to_remove = item;
		item = next(item);

		free(item_to_remove);
	}
}

void aquire_list(LinkedList *item)
{
	item->ref_count++;
}

LinkedList* insert_after(LinkedList *item, LinkedList *newItem)
{
	assert(item);
	assert(newItem);

	aquire_list(newItem);

	LinkedList *new_item_last = last_item(newItem);
	LinkedList *item_next = next(item);

	item->next = newItem;
	new_item_last->next = item_next;

	return new_item_last;
}

LinkedList* remove_after(LinkedList *item)
{
	assert(item);

	LinkedList *removing_item = next(item);

	removing_item->ref_count--;

	if (removing_item)
	{
		LinkedList *next_to_removing = next_nth(item, 2);
		item->next = next_to_removing;
	}

	return removing_item;
}

LinkedList* remove_n_after(LinkedList *item, int n)
{
	assert(item);

	LinkedList *removing_items = next(item);

	removing_items->ref_count--;

	LinkedList *last_removing_item = next_nth(item, n);

	item->next = last_removing_item ? NULL : last_removing_item->next;

	return removing_items;
}

LinkedList* last_item(LinkedList* item)
{
	while (item && next(item))
	{
		item = item->next;
	}

	return item;
}

LinkedList* next(LinkedList* item)
{
	return item->next;
}

LinkedList* next_nth(LinkedList* item, int n)
{
	while (item && n > 0)
	{
		item = next(item);
		n--;
	}

	return item;
}

int for_each(LinkedList *item, LIST_ITEM_ACTION action)
{
	while (item)
	{
		int result = (*action)(item);

		if (result != 0)
		{
			return result;
		}

		item = next(item);
	}

	return 0;
}

LinkedList* find_first(LinkedList *item, LIST_ITEM_PRED pred)
{
	while (item)
	{
		if ((*pred)(item))
		{
			break;
		}

		item = next(item);
	}

	return item;
}