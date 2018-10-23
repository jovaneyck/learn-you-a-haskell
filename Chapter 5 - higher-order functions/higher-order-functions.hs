import Test.HUnit

:{
    --functions as input, note the mandatory parentheses in the signature
    applyTwice :: (a -> a) -> a -> a
    applyTwice f x = f (f x)

    zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
    zipWith' _ [] _ = []
    zipWith' _ _ [] = []
    zipWith' f (x:xs) (y:ys) = 
        f x y : zipWith' f xs ys

    map' :: (a -> b) -> [a] -> [b]
    map' _ [] = []
    map' f (x:xs) = f x : map f xs

    tests = 
        test [
            "Currying and partial application"
                ~: 7
                ~=? let m = max 7 in m 4,
            "Partial application for infix functions"
                ~: 12
                ~=? let divideByTen = (/10) in divideByTen 120,
            "Functions as input"
                ~: 1000
                ~=? applyTwice (*10) 10,
            "zipWith"
                ~: [(1,"a"),(2,"b"),(3,"c")]
                ~=? zipWith' (\ x y -> (x,y)) [1,2,3] ["a","b","c"],
            "map"
                ~: [5,6,7]
                ~=? map' (+3) [2..4],
            "filter"
                ~: [2,4,6]
                ~=? filter even [1..7]
            ]

:}

runTestTT tests