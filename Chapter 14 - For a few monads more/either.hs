import Test.HUnit

:{

{-
instance (Error e) => Monad (Either e) where
    return x = Right x
    Right x >>= f = f x
    Left err >>= f = Left err
    fail msg = Left (strMsg msg)
-}

doEither :: Int -> Either String Int
doEither v = 
    if v == 10 then Right 11 else Left "Nope"

tests = test [ 
    "Either - return" 
        ~: Right 1337 
        ~=? return 1337,
    "Either - bind: success"
        ~: Right 1338
        ~=? ((Right 1337) >>= (\ value -> Right $ value + 1)),
    "Either - bind: failure"
        ~: Left "error details"
        ~=? (Left "error details" >>= (\ value -> Right $ value + 1)),
    "Either - do notation"
        ~: Right 11
        ~=? (do
                x <- Right 10
                y <- doEither x
                return y)
    ]

:}

runTestTT tests