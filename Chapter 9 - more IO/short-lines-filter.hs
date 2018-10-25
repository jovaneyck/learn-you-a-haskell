--also LAZILY parses content. 
-- i.e. you can give this input line by line even though the types are String 
-- type String = [Char] + [] is lazy
{-
main = do
    contents <- getContents
    putStr $ shortLinesOnly contents
-}
--pattern of IO -> transform -> IO == interact.
--Equivalent:
main = interact shortLinesOnly

shortLinesOnly :: String -> String
shortLinesOnly = unlines . filter (\line -> length line < 10) . lines