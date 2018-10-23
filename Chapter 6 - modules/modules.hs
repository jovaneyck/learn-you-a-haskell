import Test.HUnit
import Data.List
import Data.Char

:{
    
    countWords :: String -> [(String, Int)]
    countWords = map (\ g -> (head g, length g)) . group . sort . words

    isIn :: (Eq a) => [a] -> [a] -> Bool
    needle `isIn` haystack = any (needle `isPrefixOf`) $ tails haystack

    encode :: Int -> String -> String
    encode offset message =
        map (\c -> chr $ ord c + offset) message

    decode :: Int -> String -> String
    decode offset = encode (negate offset)

    digitSum :: Int -> Int
    digitSum = sum . map digitToInt . show

    firstTo :: Int -> Maybe Int --Hello Maybe!
    firstTo n = find (\x -> digitSum x == n) [1..]

    tests = 
        test [  
            "counting words" 
                ~: [("bop",1), ("wa", 3), ("wee", 2)]
                ~=? countWords "wa wa wee wa wee bop",
            "haystack"
                ~: True
                ~=? "art" `isIn` "party",
            "Cipher - encode"
                ~: "kh|#pdun"
                ~=? encode 3 "hey mark",
            "Cipher - decode"
                ~: "hey mark"
                ~=? decode 3 "kh|#pdun",
            "List.find and some char manipulation"
                ~: Just 49999
                ~=? firstTo 40
        ]
:}

runTestTT tests