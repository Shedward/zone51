import Data.List

myLength :: [a] -> Int
myLength [] = 0
myLength (_:xs) = 1 + myLength xs

mean :: (Real a,  Fractional b) => [a] -> b
mean  l = realToFrac (sum l) / genericLength l

makePall :: [a] -> [a]
makePall x = x ++ reverse x

isPall :: Eq a => [a] -> Bool
isPall l = l == reverse l

join :: a -> [[a]] -> [a]
join _ [ ] = []
join _ [l] = l
join s (x:xs) = x ++ [s] ++ join s xs


main :: IO ()
main = do
	print $ myLength l
	print $ mean l
	print $ makePall l
	print $ isPall "asdffdsa"
	print $ join ',' ["foo", "bar", "baz", "quux"]
 where
 	l = [1, 2, 3, 4]