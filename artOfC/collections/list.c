#include "list.h"

#include <assert.h>
#include <memory.h>

LinkedList* create_list(void* data, size_t size, int tag, LinkedListResult *result)
{
	LinkedList* item = malloc(sizeof(*item));
	LinkedListResult res;

	if (item != NULL)
	{
		res = LR_SUCCESS;

		item->tag = tag;
		item->size = size;
		item->data = NULL;
		item->ref_count = 0;
		item->next = NULL;

		if (data != NULL && size > 0)
		{
			item->data = malloc(size);

			if (item->data != NULL)
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

	if (result != NULL) { *result = res; }
	return item;
}

void destroy_list(LinkedList* item)
{
	item->ref_count--;

	while (item != NULL && item->ref_count == 0)
	{
		if (item->data)
		{
			free(item->data);
		}

		LinkedList *item_to_remove = item;
		item = item->next;

		free(item_to_remove);

		item = item->next;
		item->ref_count--;
	}
}

LinkedList* insert_after(LinkedList *item, LinkedList *newItem)
{
	assert(item != NULL);
	assert(newItem != NULL);

	newItem->ref_count++;

	LinkedList *new_item_last = last_item(newItem);
	LinkedList *item_next = item->next;

	item->next = newItem;
	new_item_last->next = item_next;

	return new_item_last;
}

LinkedList* remove_after(LinkedList *item)
{
	assert(item);

	LinkedList *removing_item = item->next;

	if (removing_item != NULL)
	{
		LinkedList *next_to_removing = item->next->next;
		item->next = next_to_removing;
	}

	return removing_item;
}

LinkedList* remove_n_after(LinkedList *item, int n)
{
	assert(item);

	LinkedList *removing_items = item->next;
	LinkedList *last_removing_item = next_nth(item, n);

	item->next = last_removing_item == NULL ? NULL : last_removing_item->next;

	return removing_items;
}

LinkedList* last_item(LinkedList* item)
{
	while (item != NULL && item->next != NULL)
	{
		item = item->next;
	}

	return item;
}

LinkedList* next_nth(LinkedList* item, int n)
{
	while (item != NULL && item->next != NULL && n > 0)
	{
		item = item->next;
		n--;
	}

	return item;
}

int for_each(LinkedList *item, LIST_ITEM_ACTION action)
{
	while (item != NULL)
	{
		int result = (*action)(item);

		if (result != 0)
		{
			return result;
		}

		item = item->next;
	}

	return 0;
}

LinkedList* find_first(LinkedList *item, LIST_ITEM_PRED pred)
{
	while (item != NULL)
	{
		if ((*pred)(item))
		{
			break;
		}

		item = item->next;
	}

	return item;
}