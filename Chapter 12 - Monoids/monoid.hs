import Test.HUnit

import Data.Monoid

:{

{-
class Monoid m where
    mempty :: m
    mappend :: m -> m -> m
    mconcat :: [m] -> m
    mconcat = foldr mappend mempty
-}

tests = test [ 
    "Lists under ++ are monoids" ~: [1,2] ~=? mappend mempty [1,2],
    "Lists mconcat" ~: [1..3] ~=? mconcat [[1],[2,3]],
    --Sum and Product can both be used as binary function, enter newtype Sum & Product:
    "Sum a: Num a under +" 
        ~: (0 :: Sum Int, 35 :: Int) 
        ~=? (mempty, (getSum $ (mempty + 33) `mappend` 2)),
    "Product a: Num a under *" 
        ~: (35 :: Int) 
        ~=? (getProduct $ 7 `mappend` 5),
    "Any: Bool under ||"
        ~: (Any False
            , True)
        ~=? (mempty
            , getAny . mconcat . map Any $ [False, True]),
    "All: Bool under &&"
        ~: (All True
            , False)
        ~=? (mempty
            , getAll . mconcat . map All $ [False, True]),
    "You don't need to jump through Any or All monoid magic for this use case"
        ~: (False, True)
        ~=? (and [True,False], or [True, False]),
    "Ordering under compare - works like our alphabetical sorting"
        ~: (EQ, GT)
        ~=? (mempty, mappend GT EQ),
    "Ordering under compare allows sorting on multiple criteria in an elegant fashion"
        ~: (LT, LT, GT)
        ~=? let lengthCompare x y = 
                    (length x `compare` length y) `mappend`
                    (vowels x `compare` vowels y) `mappend`
                    (x `compare` y)
                    where vowels = length . filter (`elem` "aeiou") in
                        ( lengthCompare "zen" "anna"
                        , lengthCompare "zen" "ana"
                        , lengthCompare "zen" "ann"),
    "Maybe: Monoid a => Monoid (Maybe a)"
        ~: (Nothing, Just [1,2], Just [1])
        ~=? (mempty, Just [1] `mappend` Just [2], Just [1] `mappend` Nothing),
    "Maybe: no type constraints, always keep the first value with newtype First"
        ~: Just (34 :: Int) --Int is not a Monoid!
        ~=? (getFirst $ (First (Just 34)) `mappend` First Nothing),
    "First practical use case: do we have any Justs in there?"
        ~: Just 1
        ~=? (getFirst . mconcat . map First $ [Nothing, Just 1, Just 2]),
    "Last: the logical counterpart"
    ~: Just 2
    ~=? (getLast . mconcat . map Last $ [Nothing, Just 1, Just 2])
    ]

:}

runTestTT tests