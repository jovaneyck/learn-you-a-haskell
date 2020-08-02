import Test.HUnit
import Data.Ratio

:{

newtype Prob a = Prob { getProb :: [(a, Rational)] } deriving Show

-- class Functor (f :: * -> *) where
--     fmap :: (a -> b) -> f a -> f b
--          fmap applies f but leaves probabilities the same
instance Functor Prob where
    fmap f (Prob xs) = Prob $ map (\(x, p) -> (f x, p)) xs    

flatten :: Prob (Prob a) -> Prob a
flatten (Prob xs) = Prob $ concat $ map multAll xs
    where multAll (Prob innerxs, p) = map (\(x, r) -> (x, p*r)) innerxs

applyProb :: Prob (a->b) -> Prob a -> Prob b
applyProb (Prob fun) (Prob a) = 
    Prob $ concat $ map (\ (fx, fp) -> (map (\ (as, pa) -> (fx as, fp * pa)) a)) fun

instance Applicative Prob where
    pure x = Prob [(x,1%1)]
    --(<*>) :: f (a -> b) -> f a -> f b
    (<*>) = applyProb

--Monad functions
--return: minimal context = single value with 100% probability
-- bind: m >>= f always equals join (fmap f m) for monads, so given we have a Functor instance already, we just need to figure out how to flatten probs:


-- instance Monad Prob where
--     return x = Prob [(x,1%1)]
--     -- m >>= f = flatten (fmap f m)
--     fail _ = Prob []

thisSituation :: Prob (Prob Char)
thisSituation = Prob
    [(Prob [('a',1%2),('b',1%2)], 1%4)
    ,(Prob [('c',1%2),('d',1%2)], 3%4)
    ]

tests = test [ 
    "Prob represents a probalistic value" 
        ~: [(True, 1%3),(False, 2%3)] 
        ~=? (getProb $ Prob [(True, 1%3),(False, 2%3)]),
    "Prob is a functor"
        ~: [(9, 1%1)] 
        ~=? (getProb $ fmap (*3) $ Prob [(3, 1%1)]),
    "Flattening prob"
        ~: [('a',1 % 8),('b',1 % 8),('c',3 % 8),('d',3 % 8)]
        ~=? (getProb $ flatten thisSituation),
    "Prob is an applicative"
        --TODO: applicative style
        ~: [(2,1 % 6),(4,1 % 3)]
        ~=? (getProb $ applyProb (Prob [(\x -> x*2, 1%2)]) (Prob [(1,1%3),(2,2%3)]))
    -- "Monad - return"
    --     ~: [("hello", 1%1)]
    --     ~=? return "hello"
    ]

:}

runTestTT tests