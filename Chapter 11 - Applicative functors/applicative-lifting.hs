import Test.HUnit
import Control.Applicative

:{

{-
    liftA2 :: (Applicative f) => (a -> b -> c) -> f a -> f b -> f c
    liftA2 f a b = f <$> a <*> b

    It just applies a function between two applicatives, hiding the applicative
    style that we’ve discussed. However, it clearly showcases why applicative
    functors are more powerful than ordinary functors.
    With ordinary functors, we can just map functions over one functor
    value. With applicative functors, we can apply a function between several
    functor values
-}

sequenceA :: (Applicative f) => [f a] -> f [a]
{-
    sequenceA [] = pure []
    sequenceA (x:xs) = (:) <$> x <*> sequenceA xs
-}
sequenceA = foldr (liftA2 (:)) (pure [])

tests = test [ 
    "Lifting list concat into Maybe context" 
        ~: Just [3,4] 
        ~=? liftA2 (:) (Just 3) (Just [4]),
    "sequenceA"
        ~: Just [1,2]
        ~=? sequenceA [Just 1, Just 2],
    "sequenceA with an empty box"
        ~: Nothing
        ~=? sequenceA [Just 1, Nothing, Just 2]
    ]

:}

runTestTT tests