import Prelude hiding (not, (^), (+))

class Logic a where 
	not   :: a -> a
	infixl 7 ^
	(^)   :: a -> a -> a
	infixl 6 +
	(+)   :: a -> a -> a
	infixl 5 %
	(%) :: a -> a -> a 
	infixl 4 ~>
	(~>)  :: a -> a -> a
	infixl 3 ==
	(==)  :: a -> a -> a
	allVals :: [a]

	lhs % rhs = not lhs ^ rhs + lhs ^ not rhs

data TernaryLogic = TerTrue
				  | TerFalse
				  | TerNone

instance Logic TernaryLogic where
	allVals = [TerTrue, TerNone, TerFalse]

	not TerTrue  = TerFalse
	not TerFalse = TerTrue
	not TerNone = TerNone

	TerTrue ^ TerTrue = TerTrue
	TerNone ^ _       = TerNone
	_       ^ TerNone = TerNone
	_       ^ _       = TerFalse

	TerFalse + TerFalse = TerFalse
	TerTrue  + _        = TerTrue
	_        + TerTrue  = TerTrue
	_        + _        = TerNone


	TerTrue ~> TerNone  = TerNone
	val     ~> TerFalse = not val
	_       ~> _        = TerTrue

	TerFalse == TerTrue = TerFalse
	TerNone  == TerNone = TerTrue
	TerNone  == _       = TerNone
	_        == _       = TerTrue


truthTable :: Logic a => a -> (a -> a -> a) -> [(a, a, a)]
truthTable l f = [(lhs , rhs, lhs `f` rhs) | lhs <- allVals :: a,
											 rhs <- allVals :: a]