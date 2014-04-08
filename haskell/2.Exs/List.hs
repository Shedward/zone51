module List 
	(List,
		listFromList,
		listHead,
		listTail,
		listLength,
		listMap,
		listFoldl,
		listFoldr)
where

data List a = Nil
			| Cons a (List a)

listFromList :: [a] -> List a
listFromList = foldr Cons Nil

listHead :: List a -> a
listHead Nil = error "Empty list"
listHead (Cons x _) = x

listTail :: List a -> List a
listTail Nil = error "Empty list"
listTail (Cons _ xs) = xs

listLength :: List a -> Integer
listLength Nil = 0
listLength (Cons _ xs) = 1 + listLength xs

listMap :: (a -> b) -> List a -> List b
listMap _ Nil = Nil
listMap f (Cons x xs) = Cons (f x) (listMap f xs)

listFoldl :: (b -> a -> b) -> b -> List a -> b
listFoldl _ i Nil = i
listFoldl f i (Cons x xs) = listFoldl f (f i x) xs

listFoldr :: (a -> b -> b) -> b -> List a -> b
listFoldr _ i Nil = i
listFoldr f i (Cons x xs) = f x (listFoldr f i xs)
