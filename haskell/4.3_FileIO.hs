module Main
    (main)
where

import System.IO

main :: IO ()
main = do 
    hSetBuffering stdin LineBuffering
    doLoop

doLoop :: IO ()
doLoop = do 
    putStr "Enter a command rFN wFN or q to quite:"
    command <- getLine
    case command of
        'q':_        -> return ()
        'r':filename -> do 
                putStrLn ("Reading " ++ filename)
                doRead filename
                doLoop

        'w':filename -> do putStrLn ("Writing " ++ filename)
                           doWrite filename
                           doLoop
        _            -> doLoop


bracket :: IO Handle -> (IO Handle -> IO ()) -> (IO () -> IO Handle) -> IO ()
bracket handler finish f = do f handler
                              finish handler

doRead :: String -> IO ()
doRead filename = bracket (openFile filename ReadMode)
                          hClose
                          (\h -> do contents <- hGetContents h
                                    putStrLn "The first 100 chars:"
                                    putStrLn (take 100 contents))

doWrite :: String -> IO ()
doWrite filename = bracket (openFile filename WriteMode)
                           hClose
                           (\h -> do putStrLn "Enter text to go into the file:"
                                     contents <- getLine
                                     hPutStrLn h getLine)
