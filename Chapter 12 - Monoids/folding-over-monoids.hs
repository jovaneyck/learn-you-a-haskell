import Test.HUnit
import qualified Data.Foldable as F --a lot of clashes with Prelude

:{

{-
    ghci> :t foldr
    foldr :: (a -> b -> b) -> b -> [a] -> b
    ghci> :t F.foldr
    F.foldr :: (F.Foldable t) => (a -> b -> b) -> b -> t a -> b
-}

tests = test [ 
    "Data.Foldable.fold's work on lists as [] is a Foldable instance" 
        ~: 6 
        ~=? F.foldr (+) 0 [1..3]
    ]

:}

runTestTT tests