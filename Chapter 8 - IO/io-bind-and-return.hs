import Data.Char

main = do
    line <- getLine
    if null line
    then return () 
    --return = "Pure" (wrap pure value in IO action)
    --() = unit
    else do --recursive IO Actions
        putStrLn $ reverseWords line
        main

reverseWords :: String -> String
reverseWords = unwords . map reverse . words