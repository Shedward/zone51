module Data
 (Quadriple,
    getFstPair,
    getSndPair, 
  Tuple,
    get1st,
    get2nd,
    get3rd,
    get4th)
where

import Data.Maybe ()

data Quadriple a b = Quad a a b b

getFstPair :: Quadriple a b -> (a, a)
getFstPair (Quad x y _ _) = (x, y)

getSndPair :: Quadriple a b -> (b, b)
getSndPair (Quad _ _ m n) = (m, n)


data Tuple a b c d = Tuple4 a b c d
				   | Tuple3 a b c 
				   | Tuple2 a b
				   | Tuple1 a

get1st :: Tuple a b c d -> Maybe a
get1st (Tuple1 a) = Just a
get1st (Tuple2 a _) = Just a
get1st (Tuple3 a _ _) = Just a
get1st (Tuple4 a _ _ _) = Just a 

get2nd :: Tuple a b c d -> Maybe b
get2nd (Tuple2 _ b) = Just b
get2nd (Tuple3 _ b _) = Just b 
get2nd (Tuple4 _ b _ _) = Just b
get2nd _ = Nothing

get3rd :: Tuple a b c d -> Maybe c
get3rd (Tuple3 _ _ c) = Just c
get3rd (Tuple4 _ _ c _) = Just c 
get3rd _ = Nothing

get4th :: Tuple a b c d -> Maybe d 
get4th (Tuple4 _ _ _ d) = Just d
get4th _ = Nothing