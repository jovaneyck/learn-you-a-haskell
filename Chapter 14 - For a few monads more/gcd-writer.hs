import Test.HUnit
import Control.Monad.Writer(Writer, runWriter, tell)


:{

gcd :: Int -> Int -> Writer [String] Int
gcd a b
    | b == 0 = do
        tell ["Finished with " ++ show a]
        return a
    | otherwise = do
        tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
        gcd b (a `mod` b)

tests = test [ 
    "Writer monad in action to add logging." 
        ~: ( 1
           , ["8 mod 3 = 2","3 mod 2 = 1","2 mod 1 = 0","Finished with 1"])
        ~=? (runWriter $ gcd 8 3)
    ]

:}

runTestTT tests