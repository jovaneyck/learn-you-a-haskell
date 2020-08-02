import Data.Ratio
import Test.HUnit

:{

tests = test [ 
    "No loss in precision when using rationals" ~: 1%3 ~=? 1%6 + 1%6,
    "Ratios are normalized" ~: "1 % 3" ~=? (show $ 2%6),
    "Can perform rational arithmetic" ~: 19%12 ~=? 1%3 + 5%4
    ]

:}

runTestTT tests