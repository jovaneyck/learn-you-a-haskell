import Test.HUnit

import Data.Monoid

:{

{-
class Monoid m where
    mempty :: m
    mappend :: m -> m -> m
    mconcat :: [m] -> m
    mconcat = foldr mappend mempty
-}

tests = test [ 
    "Hello world" ~: 6 ~=? 2 + 4
    ]

:}

runTestTT tests