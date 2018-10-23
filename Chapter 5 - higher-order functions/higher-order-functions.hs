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

    filter' :: (a -> Bool) -> [a] -> [a]
    filter' _ [] = []
    filter' pred (x:xs)
        | pred x = x : filter pred xs
        | otherwise = filter pred xs

    --folding over infinite lists
    --foldR instead of foldl is super-counterintuitive for me, 
    -- it looks like it's nibbling the list from the right, but it is actually evaluating from left to right?
    and' :: [Bool] -> Bool
    and' xs = foldr (&&) True xs

    tests = 
        test [
            "Currying and partial application"
                ~: 7
                ~=? let m = max 7 in m 4,
            "Sections - Partial application for infix functions"
                ~: 12
                ~=? let divideByTen = (/10) in divideByTen 120,
            "Functions as input"
                ~: 1000
                ~=? applyTwice (*10) 10,
            "lambdas"
                ~: 5
                ~=? (\ x -> x + 3) 2,
            "zipWith"
                ~: [(1,"a"),(2,"b"),(3,"c")]
                ~=? zipWith' (\ x y -> (x,y)) [1,2,3] ["a","b","c"],
            "map"
                ~: [5,6,7]
                ~=? map' (+3) [2..4],
            "filter"
                ~: [1,2,3]
                ~=? filter' (<4) [1..7],
            "filter with sections are even shorter than lambdas"
                ~: "elephants"
                ~=? takeWhile (/=' ') "elephants know how to party",
            "mapping to generate partially applied functions"
                ~: 20
                ~=? let multipliers = map (*) [0..]
                        timesFour = multipliers !! 4 in
                            timesFour 5,
            "foldl - implementing sum"
               ~: 6
               ~=? let sum xs = foldl (+) 0 xs in
                        sum [1..3],
            "foldr - map in terms of fold"
                ~: [2,4,6]
                ~=? let map' f xs = foldr (\ x acc -> f x : acc) [] xs in
                    map' (*2) [1..3],
            "foldr - elem in terms of fold"
                ~: (True, False)
                ~=? let elem' el xs = foldr (\ x acc -> if el == x then True else acc) False xs in
                    (2 `elem'` [1,2,3], 4 `elem'` [1,2,3]),
            "foldl1 works without an acc"
                ~: 6
                ~=? let sum xs = foldl1 (\ acc el -> acc + el) xs in
                        sum [1..3],
            "folding over infinite lists"
                ~: False
                ~=? and' (repeat False),
            "scan to keep running totals of the accumulator"
                ~: [0,3,8,10,11]
                ~=? scanl (+) 0 [3,5,2,1],
            "$ - use function application operator to get rid of a lot of parantheses"
                ~: 80
                ~=? (sum $ filter (> 10) $ map (*2) [2..10]),
                -- ~=? (sum (filter (> 10) (map (*2) [2..10])))
            "$ - now you can map 'application' over a list of functions"
                ~: [7.0,30.0,9.0,1.7320508075688772]
                ~=? map ($ 3) [(+4), (10*), (^2), sqrt],
            ". - use composition operator to compose functions and get rid of even more parentheses!"
                ~: [-14, -15, -27]
                ~=? map (negate . sum . tail) [[1..5],[3..6],[1..7]],
            "Combine $ and . to write next to zero parentheses"
                ~: [180,180]
                ~=? (replicate 2 . product . map (*3) $ zipWith max [1,2] [4,5]),
            "Point-free style"
                ~: 6
                ~=? let sum = foldl (+) 0 in sum [1..3]
            ]

:}

runTestTT tests