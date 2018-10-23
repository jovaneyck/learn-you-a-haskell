import Test.HUnit

:{
    collatzSequence :: Int -> [Int]
    collatzSequence 1 = [1]
    collatzSequence n
        | even n = n : collatzSequence (n `div` 2)
        | otherwise = n : collatzSequence (3 * n + 1)

    numLongChains :: Int
    numLongChains = 
        length (filter isLong (map collatzSequence [1..100]))
            where isLong xs = length xs > 15

    tests = 
        test [
            "collatz base"
                ~: [1]
                ~=? collatzSequence 1,
            "collatz even"
                ~: [2,1]
                ~=? collatzSequence 2,
            "collatz odd"
                ~: [3,10,5,16,8,4,2,1]
                ~=? collatzSequence 3,
            "collatz nontrivial"
                ~: [30,15,46,23,70,35,106,53,160,80,40,20,10,5,16,8,4,2,1]
                ~=? collatzSequence 30,
            "number of long chains"
                ~: 66
                ~=? numLongChains
        ]
:}

runTestTT tests