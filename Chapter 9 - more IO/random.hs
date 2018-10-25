import Test.HUnit
import System.Random -- λ stack install random

:{


tests = test [  
    "Get a random value with seeded generator" 
        ~: 7054720610510240562
        ~=? let generator = mkStdGen 1337
                (r,nextGenerator) = random generator :: (Int, StdGen) in
            r
        ]
:}

runTestTT tests