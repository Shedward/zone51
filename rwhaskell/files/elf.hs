import qualified Data.ByteString.Lazy as L

hasElfMagic :: L.ByteString -> Bool
hasElfMagic content  = L.take 4 content == elfMagic
	where elfMagic = L.pack [0x7f, 0x45, 0x4c, 0x46]

isElfFIle :: FilePath -> IO Bool
isElfFIle path = do
	content <- L.readFile path
	return (hasElfMagic content)