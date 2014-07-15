import System.IO
import Data.Char (toUpper)
import Control.Monad (unless)

main :: IO ()
main = do
    inh <- openFile "to-upper.hs" ReadMode
    outh <- openFile "TO-UPPER.HS" WriteMode
    mainloop inh outh
    hClose inh
    hClose outh

mainloop :: Handle -> Handle -> IO ()
mainloop inh outh =
    do ineof <- hIsEOF inh
       unless ineof $
              do inpStr <- hGetLine inh
                 hPutStrLn outh (map toUpper inpStr)
                 mainloop inh outh