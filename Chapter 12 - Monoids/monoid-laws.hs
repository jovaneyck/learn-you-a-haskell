import Test.QuickCheck
import Data.Monoid

:{
{-
    identity:
    mempty `mappend` x = x
    x `mappend` mempty = x
    associativity:
    (x `mappend` y) `mappend` z = x `mappend` (y `mappend` z)
-}

--[]
prop_list_monoid_identity :: [Int] -> Bool
prop_list_monoid_identity xs = 
    mappend mempty xs == xs && mappend xs mempty == xs


prop_list_monoid_associativity :: [Int] -> [Int] -> [Int] -> Bool
prop_list_monoid_associativity xs ys zs = 
    (xs `mappend` ys) `mappend` zs == xs `mappend` (ys `mappend` zs)

qC = quickCheck
vC = verboseCheck

:}

qC prop_list_monoid_identity
qC prop_list_monoid_associativity