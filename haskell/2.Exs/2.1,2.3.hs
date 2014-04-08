{-# OPTIONS_GHC -fno-warn-type-defaults #-}

main :: IO ()
main = do
	print $ a:b:c:nil
--	print $ (a:b:nil):c:nil
--	print $ a:b:(c:d:nil):nil
	print $ a:nil
--	print $ a:(b:c:nil):nil
--	print $ nil:nil
	print $ snd $ fst cort
		where
			a = "A"
			b = "B"
			c = "C"
--			d = "D"
			nil = []
			cort = ((1, 'a'), "abc")