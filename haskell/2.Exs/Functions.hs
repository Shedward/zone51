module Functions
	(lowercaseCount, maxAt, minAt, listAnd, listOr)
where

lowercaseCount :: String -> Integer
lowercaseCount "" = 0
lowercaseCount (x:xs) = if (x > 'a') && (x < 'z') 
						then 1 + lowercaseCount xs 
						else lowercaseCount xs

maxAt :: Ord a => [a] -> a
maxAt [] = error "Try to find maximum for []"
maxAt (x:xs) = foldl max x xs

minAt :: Ord a => [a] -> a
minAt [] = error "Try to find maximum for []"
minAt (x:xs) = foldl min x xs

listAnd :: [Bool] -> Bool
listAnd [] = error "listAnd [] undefined"
listAnd [True] = True
listAnd (x:xs) = x && listAnd xs

listOr :: [Bool] -> Bool
listOr [] = error "listOr [] undefined"
listOr [False] = False
listOr (x:xs) = x || listOr xs