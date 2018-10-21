import Test.HUnit

:{
    maximum' :: (Ord a) => [a] -> a
    maximum' [] = error "maximum of an empty list"
    maximum' [x] = x
    maximum' (x : xs) = max x (maximum' xs)

    --recursion using guards
    replicate' :: Int -> a -> [a]
    replicate' n x
        | n <= 0    = []
        | otherwise = x : replicate' (n - 1) x

    --recursion using case
    take' :: (Num i, Ord i) => i -> [a] -> [a]
    take' n xs
        | n <= 0 = []
    take' n l = 
        case l of 
            [] -> []
            (x : xs) -> x : take' (n-1) xs

    --infinitely recursive functions. Lazy ftw!
    repeat' :: a -> [a]
    repeat' x = x : repeat' x

    quicksort :: Ord a => [a] -> [a]
    quicksort [] = []
    quicksort (x : xs) =
        let pivot = x
            smaller = [e | e <- xs, e <= pivot]
            bigger = [e | e <- xs, e > pivot]
        in
            (quicksort smaller) ++ [pivot] ++ (quicksort bigger)
    tests = 
        test [
            "Recursive functions don't need no special keywords"
                ~: 33
                ~=? maximum' [2, 33, 4],
            "Replicate"
                ~: ["Jo","Jo","Jo"]
                ~=? replicate' 3 "Jo",
            "Take"
                ~: [1,2,3]
                ~=? take 3 [1..],
            "Repeat"
                ~: [1,1,1]
                ~=? take 3 (repeat 1),
            "Quicksort"
                ~: [1..5]
                ~=? quicksort [5,1,2,4,3]
            ]

:}

runTestTT tests