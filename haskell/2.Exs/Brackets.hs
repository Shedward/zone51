type ValType = Double

data Op = Plus
		| Minus
		| Mul
		| Div

ops :: [Op]
ops = [Plus, Minus, Mul, Div]

opSign :: Op -> String
opSign Plus = "+"
opSign Minus = "-"
opSign Mul = "*"
opSign Div = "/"

opEval :: Op -> ValType -> ValType -> ValType
opEval Plus = (+)
opEval Minus = (-)
opEval Mul = (*)
opEval Div = (/)

-----------------------------------------------------------

data Expr = Val ValType
		  | Expr Expr Op Expr

toStr :: Expr -> String
toStr (Val a) = show a
toStr (Expr lhs op rhs) = "(" ++ toStr lhs
							  ++ opSign op 
							  ++ toStr rhs ++ ")"

eval :: Expr -> ValType
eval (Val a) = a
eval (Expr lhs op rhs) = opEval op (eval lhs) (eval rhs)

-----------------------------------------------------------

inits :: [a] -> [[a]]
inits = scanl (\l x -> l ++ [x]) []

tails :: [a] -> [[a]]
tails = scanr (:) []

notnull :: [a] -> Bool
notnull l = not $ null l

allSplits :: [a] -> [([a], [a])]
allSplits xs = [(as, bs) | 
				(as, bs) <- zip (inits xs) (tails xs), 
							notnull as, notnull bs]

allComb :: [Expr] -> [Expr]
allComb [] = []
allComb [x] = [x]
allComb xs = [Expr lhs op rhs |
			  (leftList, rightList) <- allSplits xs,
			  lhs <- allComb leftList,
			  rhs <- allComb rightList,
			  op <- ops]

allNumComb :: [ValType] -> [Expr]
allNumComb l = allComb $ map Val l

main :: IO ()
main = do
		let x = Expr (Val 2) Plus (Expr (Val 1) Div (Val 5))
		print $ toStr x
		print $ eval x
		print $ allSplits "123456"
		print $ map (toStr . Val) [1,2,3]
		print $ map toStr (allNumComb [1,2,3])
		print $ map eval (allNumComb [1,2,3])
		print [toStr v | v <- allNumComb [1,2,3,4,5,6], 100 == eval v ]

