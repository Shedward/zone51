module Find (
	find
	)

where

find :: FilePath -> FindPred -> [IO FindPred]
find cur pred = 