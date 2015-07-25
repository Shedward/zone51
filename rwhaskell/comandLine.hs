import System.Environment (getArgs)
import Data.List (intercalate)

interactWith :: (String -> String) -> String -> String -> IO ()
interactWith function inputFile outputFile = do
	input <- readFile inputFile
	writeFile outputFile (function input)

main :: IO ()
main = do
	args <- getArgs
	case args of 
		(input:output:action:opts) -> interactWith (processor action opts) input output
		otherwise			       -> error "Exactly three arguments needed"
	where
		processor action opts =
			case (action, opts) of 
				("split", [sep]) -> intercalate "\n\n" . splitLines
				otherwise        -> error ("Action " ++ action ++ " with options " ++ opts ++ " not suported")


splitLines :: String -> [String]
splitLines [] = []
splitLines cs = 
	let (pre, suf) = break isLineTerminator cs
	in pre : case suf of 
				('\r':'\n':rest) -> splitLines rest
				('\r':rest)      -> splitLines rest
				('\n':rest)	     -> splitLines rest
				_				 -> []

	where isLineTerminator c = c == '\r' || c == '\n'