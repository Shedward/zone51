module Main where

main :: IO ()
main = do
	putStrLn "Greetings!"
	inpStr <- getLine
	putStr $ "Welcome to Haskell" ++ inpStr ++ "!"