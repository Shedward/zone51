data Complex = Complex {realPart :: Double, imagPart :: Double}

instance Num Complex where
	(Complex rl il) + (Complex rr ir) 
		= Complex (rl + rr) (il + ir)

	(Complex rl il) * (Complex rr ir)
		= Complex (rl * rr - il * ir) (rl * ir + il * rr)

	negate (Complex r i) = Complex (negate r) (negate i)
	abs (Complex r i) = Complex (abs r) (abs i)
	signum (Complex r i) = Complex (signum r) (signum i)
	fromInteger int = Complex (fromInteger int) 0

instance Show Complex where
	showsPrec p (Complex r i) = showsPrec p r .
								showString " + " . 
							    showsPrec p i .
							    showString "i"

main :: IO ()
main = do
	let c1 = Complex 2 1
	let c2 = Complex 1 6
	print c1
	print c2
	print $ c1 + c2
	print $ c1 * c2