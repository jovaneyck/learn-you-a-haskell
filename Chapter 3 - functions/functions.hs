import Test.HUnit

:{
    --pattern matching: method definition per case, top down evaluation
    lucky :: Int -> String
    lucky 7 = "LUCKY NUMBER 7"
    lucky _ = "Out of luck!"

    --recursive functions, no special keywords needed
    factorial :: Int -> Int
    factorial 0 = 1
    factorial n = n * factorial (n - 1)

    --no catchall does not give warning, only runtime error
    sayName "Jo" = "Jo"
    --"*** Exception: functions.hs:15:5-23: Non-exhaustive patterns in function sayName

    --deconstructing tuples
    addVectors :: (Int, Int) -> (Int, Int) -> (Int, Int)
    addVectors (x1,y1) (x2,y2) = (x1 + x2, y1 + y2)

    --deconstructing listt using the cons deconstructor
    firstTwo :: [a] -> (a,a)
    firstTwo (x : y : _) = (x,y)

    --guards and where statements
    --further breaking down patterns using guards, catchall = otherwise
    bmiTell :: Double -> Double -> String
    bmiTell weight height --no '=' !
        | bmi <= skinny = "You're underweight, you emo, you!"
        | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"
        | bmi <= fat = "You're fat! Lose some weight, fatty!"
        | otherwise = "You're a whale, congratulations!"
        where 
            bmi = weight / height ^ 2 --use where to define variables
            (skinny, normal, fat) = (18.5, 25, 30) --deconstructing in a where

    --let bindings allow you to define variables in front
    cylinder :: Double -> Double -> Double
    cylinder r h =
        let sideArea = 2 * pi * r * h
            topArea = pi * r ^ 2
        in sideArea + 2 * topArea

    --case expressions let you pattern match anywhere
    head' :: [a] -> a
    head' xs = case xs of 
        [] -> error "No head on empty list"
        (x : _) -> x

    tests = 
        test [
            "Pattern matching"
                ~: "LUCKY NUMBER 7"
                ~=? lucky 7,
            "Recursive functions"
                ~: 3628800
                ~=? factorial 10,
            "Deconstructing arguments"
                ~: (7,4)
                ~=? addVectors (2,1) (5,3),
            "Deconstructing lists"
                ~: (1,2)
                ~=? firstTwo [1,2,3],
            "As-patterns (@): referencing a deconstructed something"
                ~: "The first letter of Jo is J"
                ~=? let firstLetter name@(f:_) = "The first letter of " ++ name ++ " is " ++ [f]
                    in firstLetter "Jo",
            "Guards"
                ~: "You're a whale, congratulations!"
                ~=? bmiTell 120 1.90,
            "Let bindings"
                ~: 117.49556524425824
                ~=? cylinder 3.4 2.1,
            "Let is an expression, can use it basically anywhere"
                ~: (25,9,4)
                ~=? let square n = n * n in (square 5, square 3, square 2),
            "Let - can use semicolons for multiline stuff"
                ~: 6000000
                ~=? let a = 100; b = 200; c = 300 in a * b * c,
            "Let - deconstructing stuff"
                ~: 600
                ~=? (let (a,b,c) = (1,2,3) in a + b + c) * 100,
            "Let in list comprehensions"
                ~: [120]
                ~=? 
                    let calcBmis xs = [bmi | (w,h) <- xs, let bmi = w / h ^ 2]
                    in calcBmis [(120, 1.0)],
            "Case to pattern match"
                ~: 1
                ~=? head' [1,2],
            "Case can be used anywhere you expect an expression"
                ~: "The list is empty."
                ~=? 
                    let ls = [] in
                    "The list is " 
                        ++ case ls of 
                            [] -> "empty."
                            [x] -> "a singleton"
                            _ -> "a long list"
            ]

:}

runTestTT tests