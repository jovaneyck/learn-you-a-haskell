import Test.HUnit
    -- instance is just in GHC.Base now:

    -- Prelude> :i (->)
    -- instance Applicative ((->) a) -- Defined in `GHC.Base'
    -- instance Functor ((->) r) -- Defined in `GHC.Base'
    -- instance Monad ((->) r) -- Defined in `GHC.Base'
    -- instance Monoid b => Monoid (a -> b) -- Defined in `GHC.Base'
    -- instance Semigroup b => Semigroup (a -> b) -- Defined in `GHC.Base'
:{

tests = test [ 
    "application is a functor, fmap = (.)" 
        ~: 303
        -- fmap :: (a->b) -> f a -> f b
        -- fmap :: (a->b) (r->a) -> (r->b)
        -- fmap = (.)
        ~=? fmap (*3) (+100) 1

    ]

:}

runTestTT tests