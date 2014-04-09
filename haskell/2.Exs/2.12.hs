findFirst :: (a -> Bool) -> [a] -> a
findFirst _ [] = error "List is empty"
findFirst p (x:xs) = if p x then x else findFirst p xs

primes :: [Integer]
primes = primes_next [2]
	where
	notDivide :: [Integer] -> Integer -> Bool
	notDivide nums v = all (\x -> v `mod` x /= 0) nums
	nextPrime :: [Integer] -> Integer
	nextPrime xs = findFirst (notDivide xs) [(last xs)..]
	primes_next :: [Integer] -> [Integer]
	primes_next l = primes_next (l ++ [nextPrime l])