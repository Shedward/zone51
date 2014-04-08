module Main 
	(main)
where

comparsion :: Ord a => a -> a -> String
comparsion x y | x < y     = "x > y"
			   | x > y     = "x < y"
			   | otherwise = "x = y"

yesOrNo :: Bool -> String
yesOrNo p = if p then "Yes" else "No"

takeFirst :: Int -> [a] -> [a]
takeFirst n l = case (n, l) of 
	(0, _)    -> []
	(_, [])   -> []
	(n', x:xs) -> x:takeFirst (n' - 1) xs

squareRoots :: Double -> Double -> Double -> (Double, Double)
squareRoots a b c =
	let d = sqrt (b * b - 4 * a * c)
	in ((-b + d) / aa, (-b - d) / aa)
	where aa = 2 * a

fact :: Integer -> Integer
fact n = fact_acc n 1
	where
	fact_acc 0 a = a
	fact_acc n' a = fact_acc (n' - 1) (n' * a)

main :: IO ()
main = do 
	print $ comparsion '2' '5'
	print $ comparsion "Hello" "Abba"
	print $ yesOrNo ('5' > '2')
	print $ yesOrNo ("16" == "4*4")
	print $ takeFirst 10 "Hello world"
	print $ squareRoots 1 3 1
	print $ fact 6