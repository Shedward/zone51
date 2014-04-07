
-- Mathematics

primes :: [Integer]
primes = [x | x <- [2..], isPrime x]
	where 
	isPrime x = dividers x == [1, x]
	dividers x = [y | y <- [1..x], mod x y == 0]

-- Optimized

primesOpt :: [Integer]
primesOpt = 2 : [x | x <- [3, 5..], 
					 null [y | y <- [2..(div x 2)], mod x y == 0]]


-- Hard optimized

primesOpt2 :: [Integer]
primesOpt2 = 2 : nextP 3 []
	where 
	update [] = []

	update ((x, m):xs) = (if x' >= m then (x' - m, m)
									 else (x', m)):update xs
		where x' = x + 2

	nonZero x m = 0 `notElem` map fst (takeWhile less m)
		where less (_, y) = y * y <= x

	nextP x m | nonZero x m = x : nextP (x + 2) (update m ++ [(2, x)])
			  | otherwise   = nextP (x + 2) (update m)


main :: IO ()
main = do 
	print $ take 100 primes
	print $ take 100 primesOpt
	print $ take 100 primesOpt2