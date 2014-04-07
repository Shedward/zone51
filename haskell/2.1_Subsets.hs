getSubsets :: [a] -> [[a]]
getSubsets [] = [[]]
getSubsets (x:xs) = ss ++ map (x:) ss
	where ss = getSubsets xs

main :: IO ()
main = do
	print $ getSubsets "1234"
	print $ getSubsets "Hello"