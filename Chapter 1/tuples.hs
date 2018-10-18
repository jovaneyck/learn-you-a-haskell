import Test.HUnit
:{

    tests = 
        test [  "concatenation" ~: [1] ++ [2] ~=? [1,2]
            ]

:}

runTestTT tests