import Test.HUnit

:{

solveRPN :: String -> Double
solveRPN = head . foldl folder [] . words
    where
        folder (x:y:ys) "*" = (y * x):ys
        folder (x:y:ys) "+" = (y + x):ys
        folder (x:y:ys) "-" = (y - x):ys
        folder stack nb = read nb : stack

tests = test [  
    "Basic addition" ~: 8 ~=? solveRPN "3 5 +",
    "Basic subtract" ~: -4 ~=? solveRPN "10 14 -",
    "Basic multiplication" ~: 12 ~=? solveRPN "3 4 *",
    "Scenario 1" ~: -4 ~=? solveRPN  "10 4 3 + 2 * -",
    "Scenario 2" ~: -3947 ~=? solveRPN "90 34 12 33 55 66 + * - +",
    "Scenario 3" ~: 4037 ~=? solveRPN "90 34 12 33 55 66 + * - + -"
        ]
:}

runTestTT tests