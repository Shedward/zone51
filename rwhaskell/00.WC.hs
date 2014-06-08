module Main where

main :: IO ()
main = interact wordCount
	where wordCount input = show (length (lines input)) ++ "\n"