{-
    λ stack runhaskell gcd-with-io.hs
    8 mod 3 = 2
    3 mod 2 = 1
    2 mod 1 = 0
    Finished with 1
-}

import Control.Monad.Writer

{-
non-monadic version for comparison:

gcd' :: Int -> Int -> Int
gcd' a b
    | b == 0 = a
    | otherwise = gcd' b (a `mod` b)

-}

gcd' :: Int -> Int -> Writer [String] Int
gcd' a b
    | b == 0 = do
        tell ["Finished with " ++ show a]
        return a
    | otherwise = do
        tell [show a ++ " mod " ++ show b ++ " = " ++ show (a `mod` b)]
        gcd' b (a `mod` b)

main = do
    mapM_ putStrLn $ snd $ runWriter (gcd' 8 3)