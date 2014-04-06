----------------------------------------------------------
----------------------------------------------------------
--                                                      --
--  Модуль TEMPLATES - примеры построения функций для   --
--  обработки списков на основе шаблонного каркаса      --
--  типовых функций.                                    --
--                                                      --
----------------------------------------------------------
----------------------------------------------------------

module Templates
	(lstLength, lstSum, lstProduct, lstReverse, lstMap)
where

-- [ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ] -----------------------------

lstTemplate :: ([a] -> b) -> (c -> d -> b) -> (e -> c) -> 
               (b -> d) -> ([e] -> [e]) -> [e] -> b
lstTemplate f1 _ _ _ _ []         = f1 []
lstTemplate f1 f2 f3 f4 f5 (x:xs) = f2 (f3 x)
                                       (f4 (lstTemplate f1 f2 f3 
                                       	                f4 f5 (f5 xs)))

lstConstant :: a -> b -> a
lstConstant n _ = n

lstId :: a -> a
lstId some = some

lstSwap :: (a -> b -> c) -> b -> a -> c 
lstSwap op x y = op y x 

lstList :: a -> [a]
lstList x = [x]

-- [ОСНОВНЫЕ ФУНКЦИИ] ------------------------------------

lstLength :: [a] -> Integer
lstLength = lstTemplate (lstConstant 0) (+) (lstConstant 1) lstId lstId

lstSum :: [Integer] -> Integer
lstSum = lstTemplate (lstConstant 0) (+) lstId lstId lstId

lstProduct :: [Integer] -> Integer 
lstProduct = lstTemplate (lstConstant 1) (*) lstId lstId lstId

lstReverse :: [a] -> [a]
lstReverse = lstTemplate lstId (lstSwap (++)) lstList lstId lstId

lstMap :: (a -> b) -> [a] -> [b]
lstMap f = lstTemplate lstId (:) f lstId lstId