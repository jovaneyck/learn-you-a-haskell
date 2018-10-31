--usage:
--stack runhaskell main.hs < paths.txt
--or compile & run: 
-- -stack ghc main.hs
-- -stack.exe < paths.txt


import Data.List
import qualified Roadtrip

groupsOf :: Int -> [a] -> [[a]]
groupsOf 0 _ = undefined
groupsOf _ [] = []
groupsOf n xs = take n xs : groupsOf n (drop n xs)

main = do
    contents <- getContents
    let threes = groupsOf 3 (map read $ lines contents)
        roadSystem = map (\[a,b,c] -> Roadtrip.Section a b c) threes
        path = Roadtrip.optimalPath roadSystem
        pathString = concat $ map (show . fst) path
        pathTime = sum $ map snd path
    putStrLn $ "The best path to take is: " ++ pathString
    putStrLn $ "Time taken: " ++ show pathTime
