import Control.Monad
import Data.Char

--let's build a gameloop!
main = forever $ do
    putStrLn "Give me some input: "
    l <- getLine
    putStrLn $ map toUpper l