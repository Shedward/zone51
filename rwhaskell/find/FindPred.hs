module FindPred (
	FindPred,
	Selector,
	(.&&),
	(.||),
	(.!),
	(.==),
	(.>),
	(.<),
	comb,
	test,
	fileName,
	path,
	fileExt,
	fileSize
	)
where

import System.FilePath
import System.Directory (getPermissions, getModificationTime)
import System.Time (ClockTime(..))
import Data.Time.Clock
import FileUtils as FU

type FindPred = FilePath -> Bool
type Selector a = FilePath -> IO a

comb :: (Bool -> Bool -> Bool) -> FindPred -> FindPred -> FindPred
comb op l r x = l x `op` r x 

(.&&) :: FindPred -> FindPred -> FindPred
(.&&) = comb (&&)

(.||) :: FindPred -> FindPred -> FindPred
(.||) = comb (||)

(.!) :: FindPred -> FindPred
(.!) ex = not . ex

test op sel val p = sel p `op` val

(.==) = test (==)

(.>) = test (>)

(.<) = test (<)

fileName :: Selector FilePath
fileName = return . takeFileName

path :: Selector FilePath
path = return

fileExt :: Selector String
fileExt = return . takeExtensions

modified :: Selector (IO UTCTime)
modified = return . getModificationTime