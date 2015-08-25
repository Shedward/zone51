#ifndef LIST_H
#define LIST_H

#include <stdlib.h>

/*
 * Structure that represent element of linked list.
 */

typedef struct LinkedList
{
	/*
	 * Pointer to data storing by list.
	 * List manage memory for data by itself.
	 * You shouldn't allocate or free memory for it.
	 */

	void* data;

	/*
	 * Pointer to next element of list.
	 * Or NULL if it's last item.
	 */

	struct LinkedList* next;

	/*
	 * Size of storing data.
	 */

	size_t size;

	/*
	 * Storing aditional information about list item.
	 * Use it to store type of storing data.
	 */

	int tag;

	/*
	 * Store count of references to this item.
	 * If ref_count is 0, item can be safely deallocate.
	 * Function add_after, remove_after and destroy_item
	 * handle this value by itself. It's shouldn't be changed 
	 * manualy.
	 */

	int ref_count;

} LinkedList;


/*
 * Represent result of list operation.
 */

typedef enum LinkedListResult
{
	/*
	 * Operation finished successfully.
	 */

	LR_SUCCESS = 0,

	/*
	 * Operation require next item which not found.
	 */

	LR_NO_NEXT_ITEM,

	/*
	 * Can't allocate enought memory for finishing operation
	 */

	LR_NO_MEM

} LinkedListResult;

/*
 * Create list item. It's copy data to new allocated space.
 * If item is not NULL, it's use already allocated memory.
 */

LinkedList* create_list(void* data, size_t size, int tag, LinkedListResult *result);

/*
 * Destroy list item and items linked to it if they have no 
 * other links.
 */

void destroy_list(LinkedList* item);

/*
 * Aquire list item ownership. It's prevent 
 * automatic item deallocation from this item 
 * and it's kids. After using this item must
 * be destroying by destroy_list to prevent 
 * memroy leaking.
 */

void aquire_list(LinkedList* item);

/*
 * Insert all items from newItem to last_item(newItem) after item, 
 * If item have another item before it's add that item before new item. 
 * Return last inserted item.
 * 
 * Example:
 *  LinkedList *B;  // A -> B -> C;
 *  LinkedList *X;  // X -> Y;
 *  ...
 *  insert_after(B, X); // A -> B -> X -> Y -> C;
 */

LinkedList* insert_after(LinkedList* item, LinkedList *newItem);

/*
 * Remove next item. If next item not exist return LR_NO_NEXT_ITEM.
 * Return removed_item.
 */

LinkedList* remove_after(LinkedList* item);

/*
 * Remove n item after selected.
 * Return list of removed items.
 */

LinkedList* remove_n_after(LinkedList* item, int n);

/*
 * Return next nth item from start item.
 * With n = 0 return start item itself.
 * If there is no nth item, return NULL.
 */

LinkedList* next_nth(LinkedList* startItem, int n);

/*
 * Return last item of list or NULL 
 * if item is NULL
 */

LinkedList* last_item(LinkedList* item);

/*
 * Predicat for list item.
 */

typedef int (*LIST_ITEM_PRED)(LinkedList* item);

/*
 * Action for list item.
 * Must return 0 if action successfully finished.
 */

typedef int (*LIST_ITEM_ACTION)(LinkedList* item);

/*
 * Perform action for every item in the list.
 * If action return non zero value loop breaking 
 * and for_each return this value.
 */

int for_each(LinkedList *firstItem, LIST_ITEM_ACTION action);

/*
 * Find first item in a list which pass predicate.
 * If such item not found return NULL.
 */

LinkedList* find_first(LinkedList *firstItem, LIST_ITEM_PRED pred);

#endif