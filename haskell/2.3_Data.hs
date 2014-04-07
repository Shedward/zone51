
data Triple a b c = Triple a b c

tripleFst :: Triple a b c -> a
tripleFst (Triple x _ _) = x

tripleSnd :: Triple a b c -> b
tripleSnd (Triple _ y _) = y

tripleThr :: Triple a b c -> c
tripleThr (Triple _ _ z) = z

data Maybe a = Nothing
			 | Just a

data Color = Red 
		   | Orange
		   | Yellow
		   | Green
		   | Blue
		   | Purple
		   | White
		   | Black

type Point3D  a = (a, a, a)
type DiscretPoint3D = Point3D Int