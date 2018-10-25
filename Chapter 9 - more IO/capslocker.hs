-- stack ghc capslocker.hs
-- .\capslocker.exe < inputfile
-- or .\capslocker.exe + stdin (readLine)
import Control.Monad
import Data.Char
{-
main = forever $ do
    l <- getLine
    putStrLn $ map toUpper l
-}
-- equivalent:
main = do
    contents <- getContents
    putStrLn $ map toUpper contents