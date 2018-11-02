import Test.HUnit

:{

tests = test [ 
    "Hello world" ~: 6 ~=? 2 + 4
    ]

:}

runTestTT tests