data PhoneNum =	
	PhoneNum
		{ userName :: String,
		  isOnline :: Bool,
		  phoneNum :: String }
	deriving (Eq, Show)

instance Ord PhoneNum where
	PhoneNum _ _ lhs > PhoneNum _ _ rhs = lhs > rhs

main :: IO ()
main = do
	let num = PhoneNum "Aaa" True "NaN"
	let num2 = PhoneNum{ userName = "Bbb",
						 isOnline = True,
						 phoneNum = "baN" }
	print num
	print num2
	print $ num < num2