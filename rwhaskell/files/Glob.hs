module Glob (nameMatching) where

import System.Directory ( 
	doesDirectoryExist,
	doesFileExist,
	getCurrentDirectory,
	getDirectoryContents
	)

import System.FilePath (
	dropTrailingPathSeparator,
	splitFileName,
	(</>)
	)

import Control.Exception (handle)
import Control.Monad (forM)
import GlobRegex (matchesGlob)

isPattern :: String -> Bool
isPattern = any (`elem` "[*?")

nameMatching :: String -> [String]
nameMatching pat 
	| not . isPattern pat = do
		exist <- doesNameExist pat
		return (if exist then [pat] else [])
	| otherwise = do
		case splitFileName pat of
			("", baseName)      -> listMatches getCurrentDirectory baseName
			(dirName, baseName) -> do
				dirs <- if isPattern dirName
						then nameMatching (dropTrailingPathSeparator dirName)
						else return [dirName]
				listDir <- if isPattern baseName
						   then listMatches
						   else listPlain
				pathNames <- forM dirs $ \dir -> do
								baseNames <- listDir dir baseName
								return (map (dir </>) baseNames)
				return (concat pathNames)

doesNameExist :: FilePath -> IO Bool
doesNameExist name = (doesFileExist name) `or` (doesDirectoryExist)

listMatches :: FilePath -> String -> IO [String]
listMatches dirName pat = do
	dirName' <- if null dirName
				then getCurrentDirectory
				else return dirName
	handle (const (return [])) $ do
		names <- getDirectoryContents dirName'
		let names' = if isHidden pat
					 then filter isHidden names
					 else filter (not . isHidden) names
		return (filter (`matchesGlob` pat) names')

isHidden :: String -> Bool
isHidden ('.':_) = True
isHidden _       = False

listPlain :: FilePath -> String -> IO [String]
listPlain dirName baseName = do
	exists <- if null baseName
			  then doesDirectoryExist dirName
			  else doesNameExist (dirName </> baseName)
	return (if exists then [baseName] else [])