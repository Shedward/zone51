
fermatT :: Integer -> Integer
fermatT 1 = 1
fermatT n = n + fermatT (n - 1)

fermatP :: Integer -> Integer
fermatP 1 = fermatT 1
fermatP n = fermatT n + fermatP (n - 1)

factorialsList :: [Integer]
factorialsList = map (\ n -> product[1..n]) [1..]

getN :: Integer -> [a] -> a
getN _ [] = error "List is empty"
getN 1 (x:_) = x
getN n (_:xs) = getN (n - 1) xs

atomPosition :: Eq a => a -> [a] -> Integer
atomPosition _ [] = error "Not found"
atomPosition a (x:xs) = 
	if a == x 
		then 1
		else 1 + atomPosition a xs

atomInsert :: a -> Integer -> [a] -> [a]
atomInsert _ _ [] = error "Not reach position"
atomInsert a 1 lst = a : lst
atomInsert a pos (x:xs) = x : atomInsert a (pos - 1) xs

decrement :: Integer -> Integer
decrement 1 = 0
decrement i = 1 + decrement (i - 1)

main :: IO ()
main = do
	print (fermatT 10)
	print (fermatP 10)
	print (take 10 factorialsList)
	print (getN 5 factorialsList)
	print (atomPosition 720 factorialsList)
	print (atomInsert '@' 4 "123456789")
