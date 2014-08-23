{-# LANGUAGE ScopedTypeVariables #-}

module FileUtils (
    fileSize
    ) 
where

import Control.Exception
import System.IO

fileSize :: FilePath -> IO (Maybe Integer)
fileSize path = handle (\(_ :: SomeException) -> return Nothing) $ 
    withFile path ReadMode $ \h -> do
        size <- hFileSize h 
        return (Just size)
