
globToRegex' :: String -> String
globToRegex' ""             = ""
globToRegex' ('?':c:cs)     = ".*" ++ c : globToRegex' cs
globToRegex' ('[':'!':c:cs) = "[^" ++ globToRegex' cs
globToRegex' ('[':c:cs)     = '[' : c : charClass cs
globToRegex' ('[':_)        = error "Unterminated character class"
globToRegex' (c:cs)         = escape c ++ globToRegex' cs

escape :: Char -> String
escape c | c `elem` regexChars = '\\' : [c]
         | otherwise           = [c]
    where regexChars = "\\+()^$.{}]|"

charClass :: String -> String
charClass (']':cs) = ']' : globToRegex' cs
charClass (c:cs)   = c : charClass cs
charClass []       = error "Unterminated character class"
