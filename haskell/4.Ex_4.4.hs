module Main where

import System.IO

main :: IO ()
main = case readLn of 
        "read"  -> fileRead
        "write" -> fileWrite
        "quit"  -> return
        otherwise -> main

fileRead :: IO ()
fileRead = do putStrLn "Input file name:"
              fn <- readLn
              fh <- openFile fn
              putStrLn $ getContents fh
              hClose fh
