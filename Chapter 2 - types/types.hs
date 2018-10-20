import Test.HUnit

--find any expression's type in GHCi by using :t <expression>

:{
    --type signatures are optional but idiomatic (keep 'm generic)
    removeNonUppercase :: [Char] -> [Char]
    removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]

    --Int: bounded integer
    addThree :: Int -> Int -> Int -> Int
    addThree x y z = x + y + z

    --Integer: unbounded integer
    factorial :: Integer -> Integer
    factorial n = product [1..n]
    
    --Float
    circumference :: Float -> Float
    circumference r = 2 * pi * r

    --Double (double precision)
    circumference' :: Double -> Double
    circumference' r = 2 * pi * r


    tests = 
        test [
            "Int"
                ~: (6 :: Int)
                ~=? addThree 1 2 3,
            "Integer"
                ~: (30414093201713378043612608166064768844377641568960512000000000000
                    :: Integer)
                ~=? (factorial 50),
            "Float"
                ~: (25.132742 :: Float)
                ~=? circumference 4.0,
            "Double"
                ~: (25.132741228718345 :: Double)
                ~=? circumference' 4.0,
            "Type classes - Show can used for toString"
                ~: "True"
                ~=? show True,
            "Type classes - Read can be used to parse"
                --this run-time errors in case of a problem. DO NOT USE if you don't trust input
                ~: True
                ~=? read "True",
            "Type annotations - necessary if compiler cannot figure it out"
                ~: "4"
                ~=? show (read "4" :: Int),
            "Type classes - Enum can be used to iterate/range/succ"
                ~: [LT,EQ,GT]
                ~=? [LT .. GT],
            "Type classes - Bounded have lower and upper bounds"
                ~: (maxBound :: Int)
                ~=? 9223372036854775807,
            "Tuples 'inherit' typeclasses from elemnts if all elements are instances"
                ~: (True, 9223372036854775807)
                ~=? (maxBound :: (Bool, Int)),
            "Type classes - Integral to lift numbers to a more general type"
                ~: 3.2
                ~=? (fromIntegral (length [1,2])) + 1.2
            ]

:}

runTestTT tests