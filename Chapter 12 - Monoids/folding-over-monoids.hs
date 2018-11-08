import Test.HUnit
import qualified Data.Foldable as F --a lot of clashes with Prelude
import Data.Monoid

:{

{-
    ghci> :t foldr
    foldr :: (a -> b -> b) -> b -> [a] -> b
    ghci> :t F.foldr
    F.foldr :: (F.Foldable t) => (a -> b -> b) -> b -> t a -> b

    class Foldable (t :: * -> *) where
        F.fold :: Monoid m => t m -> m
        foldMap :: Monoid m => (a -> m) -> t a -> m
        foldr :: (a -> b -> b) -> b -> t a -> b
        foldl :: (b -> a -> b) -> b -> t a -> b
-}

data Tree a = EmptyTree | Node a (Tree a) (Tree a) deriving (Show)

--foldMap
instance F.Foldable Tree where
    --monoid alert
    --foldMap :: Monoid m => (a -> m) -> t a -> m
    foldMap f EmptyTree = mempty
    foldMap f (Node x l r) = F.foldMap f l  `mappend`
                             f x            `mappend`
                             F.foldMap f r

testTree = 
    Node 5
        (Node 3
            (Node 1 EmptyTree EmptyTree)
            (Node 6 EmptyTree EmptyTree))
        (Node 9
            (Node 8 EmptyTree EmptyTree)
            (Node 10 EmptyTree EmptyTree))

tests = test [ 
    "Data.Foldable.fold's work on lists as [] is a Foldable instance" 
        ~: 6 
        ~=? F.foldr (+) 0 [1..3],
    "Maybe is Foldable"
        ~: (2, 0)
        ~=? ( (F.foldl (+) 0 (Just 2))
            , (F.foldl (+) 0 Nothing)),
    "Folding over a custom data type - via foldMap"
        ~: (42, 64800)
        ~=? (F.foldl (+) 0 testTree, F.foldl (*) 1 testTree),
    "foldMap alternate use case: reducing to a Monoid value: element?"
        ~: True --do we have an 8 in there?
        ~=? (getAny $ F.foldMap (\x -> Any $ x == 8) testTree),
    "foldMap alternate use case: reducing to a Monoid value: toList"
        ~: [1,3,6,5,8,9,10]
        ~=? F.foldMap (\x -> [x]) testTree
    ]

:}

runTestTT tests