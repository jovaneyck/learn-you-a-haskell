import Test.HUnit

:{

newtype DiffList a = DiffList { getDiffList :: [a] -> [a] }

toDiffList :: [a] -> DiffList a
toDiffList xs = DiffList (xs++)

fromDiffList :: DiffList a -> [a]
fromDiffList (DiffList f) = f []

instance Semigroup (DiffList a) where
    (<>) (DiffList f) (DiffList g) = DiffList (\xs -> f (g xs)) --function composition instead of a (heavy) ++

instance Monoid (DiffList a) where
    mempty = DiffList (\xs -> [] ++ xs)
    --uses Semigroup's <>: (DiffList f) `mappend` (DiffList g) = DiffList (\xs -> f (g xs)) --function composition instead of a (heavy) ++

tests = test [ 
    "DiffLists can be used as a list with a cheap append" 
        ~: [1,2,3,4] 
        ~=? fromDiffList ((toDiffList [1,2]) `mappend` (toDiffList [3,4]))
    ]

:}

runTestTT tests