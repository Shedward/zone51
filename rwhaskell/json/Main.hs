module Main (main) where

import JSON

main :: IO ()
main = print (JObject [("foo", JNumber 1), ("bar", JBool False)])