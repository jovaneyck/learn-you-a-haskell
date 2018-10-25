import System.IO
import qualified Control.Exception

--bare bones IO
{-
main = do
    handle <- openFile "girlfriend.txt" ReadMode
    contents <- hGetContents handle --h* equivalent functions operate on a file handle
    putStr contents
    hClose handle
-}

--withFile handles open/closing for us
{-
main = do
    withFile "girlfriend.txt" ReadMode (\handle -> do
        contents <- hGetContents handle
        putStr contents)
-}

--since file read/write is so common, some shorthands:
{-
main = do
    contents <- readFile "girlfriend.txt"
    putStr contents
-}

--bracket handles files and closing on error, like try-finally:
main = do
    Control.Exception.bracket 
        (openFile "girlfriend.txt" ReadMode)
        (\handle -> hClose handle) --"finally"
        (\handle -> do
            contents <- hGetContents handle
            putStr contents) --"try"