import Control.Monad

main = do
    input <- getLine
    when (input == "password") $ do
        putStrLn "Correct!"
-- why u need this? no else return () necessary