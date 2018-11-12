import Test.HUnit

:{

tests = test [ 
    "do notation for cleaner monadic sequencing" 
        ~: (Just "3!", Just "3!")
        ~=? (Just 3 >>= (\x ->
             Just "!" >>= (\y ->
             Just (show x ++ y))),
             --equivalent to:
             do
                x <- Just 3
                y <- Just "!" 
                return $ show x ++ y)
    ]

:}

runTestTT tests