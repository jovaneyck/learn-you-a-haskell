import Test.HUnit
import Control.Monad(foldM)

:{

readMaybe :: (Read a) => String -> Maybe a
readMaybe st = 
    case reads st of 
        [(x, "")] -> Just x
        _ -> Nothing

foldingFunction :: [Double] -> String -> Maybe [Double]
foldingFunction (x:y:ys) "*" = return ((y * x):ys)
foldingFunction (x:y:ys) "+" = return ((y + x):ys)
foldingFunction (x:y:ys) "-" = return ((y - x):ys)
foldingFunction xs numberString = fmap (:xs) (readMaybe numberString)

solveRPN :: String -> Maybe Double
solveRPN st = do
    [result] <- foldM foldingFunction [] (words st)
    return result

tests = test [ 
    "situation normal" ~: Just 18 ~=? solveRPN "4 2 + 3 *",
    "incomplete input" ~: Nothing ~=? solveRPN "3 2",
    "gibberish" ~: Nothing ~=? solveRPN "invalid input",
    "non-parsable number" ~: Nothing ~=? solveRPN "1 2two +"
    ]

:}

runTestTT tests