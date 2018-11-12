import Test.QuickCheck
import Control.Monad((<=<))

:{

{-
Monadic composition with (<=<)

(.) :: (b -> c) -> (a -> b) -> (a -> c)
f . g = (\x -> f (g x))

(<=<) :: (Monad m) => (b -> m c) -> (a -> m b) -> (a -> m c)
f <=< g = (\x -> g x >>= f)

-}

f x = [x,-x]
g x = [x * 3, x * 2]
h x = [x + 1, x - 1]

prop_associativity xs = 
    (==)
        (xs >>= (f <=< (g <=< h)))
        (xs >>= ((f <=< g) <=< h))

prop_left_identity xs =
    (==)
        (xs >>= (f <=< return))
        (xs >>= f)

prop_right_identity xs =
    (==)
        (xs >>= (return <=< f))
        (xs >>= f)

qC = quickCheck
vC = verboseCheck

:}

qC prop_associativity
qC prop_left_identity
qC prop_right_identity