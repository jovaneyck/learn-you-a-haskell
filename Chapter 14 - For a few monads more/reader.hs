import Test.HUnit

:{

{-
Function application. Context = "promise of a value".
Also known as the "Reader" monad, because all "composed" functions read from the same source

instance Monad ((->) r) where
    return x = \_ -> x
    h >>= f = \w -> f (h w) w

-}

tests = test [ 
    "Reminder: Applicative ->" 
        ~: 19
        ~=? let f = (+) <$> (*2) <*> (+10)
                in f 3,
    "-> Monad in do notation"
        ~: 19
        ~=? let addStuff = do
                a <- (*2)
                b <- (+10)
                return (a+b)
            in addStuff 3
    ]

:}

runTestTT tests