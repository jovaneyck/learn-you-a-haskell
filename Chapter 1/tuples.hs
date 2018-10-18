import Test.HUnit
:{

    tests = 
        test [
            "tuples can contain heterogeneous types"
                ~: (1337, "text", True)
                ~=? (1337, "text", True),
            "pairs - fst" ~: 1 ~=? fst (1,2),
            "pairs - snd" ~: 2 ~=? snd (1,2),
            "zipping lists"
                ~: [(1,2),(2,3), (3,4),(4,5)]
                ~=? zip [1..4] [2..],
            "triangles"
               ~: [(6,8,10)]
               ~=? [ (a,b,c) 
                        | c <- [1..10], 
                          b <- [1..c], 
                          a <- [1..b],
                          a^2 + b^2 == c^2,
                          a + b + c == 24]
            ]

:}

runTestTT tests