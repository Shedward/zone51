import Functions (lowercaseCount, 
				  minAt, 
				  maxAt,
				  listOr,
				  listAnd)

main :: IO ()
main = do 
	print $ lowercaseCount "HellO WORLd"
	print $ minAt "Helloworld"
	print $ maxAt "Helloworld"
	print $ listOr [False, False, False, True]
	print $ listAnd [True, True, False, True]
