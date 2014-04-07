headDuplicate :: [a] -> [a]
headDuplicate [] = []
headDuplicate l@(x:_) = x:l

add :: Num a => (a, a) -> a
add (x,y) = x + y

inc :: Num a => a -> a
inc = (+ 1)

swap :: (a -> b -> c) -> b -> a -> c
swap f x y = f y x

no :: (b -> c) -> (a -> b) -> a -> c
f `no` g = f . g