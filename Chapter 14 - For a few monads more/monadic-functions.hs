import Test.HUnit
import Control.Monad(join, filterM)
import Control.Monad.Writer

:{

--Monad now _hase_ type constraints: Applicative m => Monad m
--so "liftM" (=fmap) & "ap" (=<*>) makes no sense anymore

--normal value in, monadic Bool out -> can filterM
--filterM :: Applicative m => (a -> m Bool) -> [a] -> m [a]
keepSmallNumberLogged :: Int -> Writer [String] Bool
keepSmallNumberLogged n =
    if n < 4 then do
        tell ["Small number, keeping " ++ show n]
        return True
    else do
        tell ["Large number, chucking out " ++ show n]
        return False

--if you treat lists as "non-deterministic computations", this makes sense
powerset = filterM (\x -> [True, False])

--foldM :: (Foldable t, Monad m) => (b -> a -> m b) -> b -> t a -> m b
binSmalls :: Int -> Int -> Maybe Int
binSmalls acc x
    | x > 9 = Nothing
    | otherwise = Just (acc + x)

tests = test [ 
    "flattening monadic values with join - maybe" 
        ~:  ( Just "hey"
            , Nothing
            , Nothing)
        ~=? ( join (Just (Just "hey"))
            , join (Just Nothing)
            , join (Nothing)),
    "flattening monadic values with join - []"
        ~: [1..6]
        ~=? join [[1], [2,3], [4..6]],
    "isomorphism between >>= and join fmap"
        ~:  ( Just 3
            , Just 3)
        ~=? (   Just 2 >>= (\x -> Just $ x + 1)
            , (join $ fmap (\x -> Just $ x + 1) (Just 2))),
    "filterM with Writer monadic values"
        ~: ([1,2,3],["Small number, keeping 1","Small number, keeping 2","Small number, keeping 3","Large number, chucking out 4","Large number, chucking out 5"])
        ~=? (runWriter $ filterM keepSmallNumberLogged [1..5]),
    "filterM with Lists as an easy trick to generate powersets"
        ~: [[1,2,3],[1,2],[1,3],[1],[2,3],[2],[3],[]]
        ~=? powerset [1,2,3],
    "foldM - folding in monadic context"
        ~:  ( Just 14
            , Nothing)
        ~=? ( foldM binSmalls 0 [2,8,3,1]
            , foldM binSmalls 0 [2,10,3,1])
    ]

:}

runTestTT tests