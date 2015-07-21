import Data.List

-- Part 1. Length

myLength :: [a] -> Integer
myLength [] = 0
myLength (_:xs) = 1 + myLength xs

lengthTest :: IO ()
lengthTest = do
    print $ myLength [1, 2, 3]
    print $ myLength ["a", "b"]

-- Part 2. Mean

mean :: [Double] -> Double
mean [] = 0
mean l = sum l / len l
    where
        sum [] = 0.0
        sum (x:xs) = x + sum xs
        len [] = 0.0
        len (x:xs) = 1 + len xs

meanTest :: IO ()
meanTest = do
    print $ mean [1,2,3]
    print $ mean [1.0, 2.0, 3.2]

-- Part 3. Palindrom

reverseList :: [a] -> [a]
reverseList [] = []
reverseList (x:xs) = reverseList xs ++ [x]

palidrom :: [a] -> [a]
palidrom [] = []
palidrom l = l ++ reverseList l

isPalindrom :: Eq a => [a] -> Bool
isPalindrom l = l == reverseList l

palidromTest :: IO ()
palidromTest = do 
    print $ palidrom [1,2,3]
    print $ palidrom "Check"
    print $ isPalindrom "aweewa"
    print $ isPalindrom "Check"

-- Part 4. Sorting

sortByLength :: [[a]] -> [[a]]
sortByLength = sortBy lengthComp
    where lengthComp lhs rhs = compare (length lhs) (length rhs)

sortByLengthTest :: IO ()
sortByLengthTest = do
    print $ sortByLength [[1], [], [1,2,3]]
    print $ sortByLength ["Hello", "my", "name", "is", "Tom"]

-- Part 5. Join

myIntersperse :: a -> [[a]] -> [a]
myIntersperse _ [] = []
myIntersperse _ (x:[]) = x
myIntersperse sep (x:xs) = x ++ [sep] ++ myIntersperse sep xs

myIntersperseTest :: IO ()
myIntersperseTest = do 
    print $ myIntersperse (-1) [[1],[2,3,4],[5],[]]
    print $ myIntersperse 0 []
    print $ myIntersperse ',' ["Hello", "world", "Check"]

-- Part 6. Tree height

data Tree a = Node { left :: Tree a, right :: Tree a}
          | Leaf a
          | Empty
            deriving (Show)

height :: Tree a -> Integer
height Empty = 0
height (Leaf _) = 1
height (Node l r) = 1 + max (height l) (height r)

heightTest :: IO ()
heightTest = do 
    print $ height (Node (Node Empty (Leaf "Test2")) (Leaf "Test"))
    print $ height (Node Empty Empty)
    print $ height (Node Empty (Node Empty (Node Empty (Node Empty (Leaf 1)))))


-- Part 7. Points 

data Point = Point { xCoor :: Float, yCoor :: Float }
    deriving (Show)

data Direction = LeftRot | RightRot | None 
    deriving (Show)

direction :: Point -> Point -> Point -> Direction
direction a b c
    | ay > cy = RightRot
    | ay < cy = LeftRot
    | otherwise = None
    where 
        a0 = Point (xCoor a - xCoor b) (yCoor a - yCoor b)
        c0 = Point (xCoor c - xCoor b) (yCoor c - yCoor b)
        ay = atan (yCoor a0 / xCoor a0) -- Use arg formula instead
        cy = atan (yCoor c0 / xCoor c0) -- arctangents.

groupsBy :: Int -> [a] -> [[a]]
groupsBy c l
    | length l < c = []
    | otherwise = take c l : groupsBy c (tail l)

directions :: [Point] -> [Direction]
directions l
    | length l < 3 = []
    | otherwise = direction a b c : directions (tail l)
        where (a:b:c:_) = l

directionsTest :: IO ()
directionsTest = do
    print $ direction (Point 0 0) (Point 1 1) (Point 2 2)
    print $ direction (Point 0 (-1)) (Point (-1) 0) (Point 1 0)
    print $ groupsBy 3 [Point 0 1, Point (-1) 0, Point 0 (-1), Point 1 0]
    print $ directions [Point 0 1, Point (-1) 0, Point 0 (-1), Point 1 0]

main :: IO ()
main = do
    lengthTest
    meanTest
    palidromTest
    sortByLengthTest
    myIntersperseTest
    heightTest
    directionsTest