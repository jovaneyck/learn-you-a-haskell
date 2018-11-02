import Test.QuickCheck

:{
--law 1: fmap id = id
--law 2: fmap (f . g) = fmap f . fmap g

--Maybe
prop_maybe_functor_id :: Maybe Int -> Bool
prop_maybe_functor_id m = id m == fmap id m 

prop_maybe_functor_comp :: Maybe Int -> Bool
prop_maybe_functor_comp m =
    let f = (+1)
        g = (*2) in
            fmap (f . g) m == ((fmap f) . (fmap g)) m
--List
prop_list_functor_id :: [Int] -> Bool
prop_list_functor_id xs = id xs == fmap id xs

prop_list_functor_comp :: [Int] -> Bool
prop_list_functor_comp xs = 
    let f = (+1)
        g = (*2) in
            fmap (f . g) xs == ((fmap f) . (fmap g)) xs

--Breaking the Laws
data CMaybe a = CNothing | CJust Int a deriving (Show, Eq)
instance Functor CMaybe where
    fmap f CNothing = CNothing
    fmap f (CJust counter x) = CJust (counter + 1) (f x)
instance Arbitrary a => Arbitrary (CMaybe a) where
    arbitrary = oneof [something, nothing]
        where something = do
                n <- arbitrary
                return $ CJust 0 n
              nothing = do return CNothing

prop_cmaybe_functor_id :: CMaybe Int -> Bool
prop_cmaybe_functor_id m = id m == fmap id m

prop_cmaybe_functor_comp :: CMaybe Int -> Bool
prop_cmaybe_functor_comp m = 
    let f = (+1)
        g = (*2) in
            fmap (f . g) m == ((fmap f) . (fmap g)) m    

qC = quickCheck
vC = verboseCheck

:}

qC prop_maybe_functor_id
qC prop_maybe_functor_comp

qC prop_list_functor_id
qC prop_list_functor_comp

qC prop_cmaybe_functor_id --Fails for CJust 0 0
-- Prelude Test.HUnit Test.QuickCheck> fmap id (CJust 0 0)
-- CJust 1 0
-- Prelude Test.HUnit Test.QuickCheck> id (CJust 0 0)
-- CJust 0 0

qC prop_cmaybe_functor_comp --Fails for CJust 0 0
-- Prelude Test.HUnit Test.QuickCheck> let f = (+1)
-- Prelude Test.HUnit Test.QuickCheck> let g =(+2)
-- Prelude Test.HUnit Test.QuickCheck> let m = CJust 0 0
-- Prelude Test.HUnit Test.QuickCheck> fmap (f.g) m
-- CJust 1 3
-- Prelude Test.HUnit Test.QuickCheck> (fmap f) . (fmap g) $ m
-- CJust 2 3