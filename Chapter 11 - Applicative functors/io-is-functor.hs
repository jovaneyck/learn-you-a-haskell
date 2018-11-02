--stack runhaskell functor-redux.hs
import Data.Char
import Data.List

main = do 
        --IO is a Functor (i.e. you can fmap over it)
        line <- fmap reverse getLine
        putStrLn $ "You said " ++ line ++ " in reverse"
        --this is useful because you can compose a normal function that works on strings and fmap that over an IO action:
        let parse = (intersperse '-' . reverse . map toUpper)
        nextLine <- fmap parse getLine
        putStrLn nextLine
