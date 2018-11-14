import Test.HUnit
import Data.Monoid
import Control.Monad.Writer

:{

{-
newtype Writer w a = Writer { runWriter :: (a, w) }

instance (Monoid w) => Monad (Writer w) where
    return x = Writer (x, mempty)
    (Writer (x, v)) >>= f = let (Writer (y, v')) = f x in Writer (y, v `mappend` v')
-}

isBigGang :: Int -> (Bool, String)
isBigGang x = (x > 9, "Compared gang size to 9.")

applyLog :: (Monoid m) => (a, m) -> (a -> (b, m)) -> (b, m)
applyLog (x, log) f = let (y, newLog) = f x in (y, log `mappend` newLog)

type Food = String
type Price = Sum Int

addDrink :: Food -> (Food, Price)
addDrink "beans" = ("milk", Sum 25)
addDrink "jerky" = ("whiskey", Sum 99)
addDrink _ = ("beer", Sum 30)

logNumber :: Int -> Writer [String] Int
logNumber x = writer (x, ["Got number: " ++ show x])

multWithLog :: Writer [String] Int
multWithLog = do
    a <- logNumber 3
    b <- logNumber 5
    tell ["Gonna multiply these numbers"] --tell to just "print" something without an associated value
    return (a*b)


tests = test [ 
    "applyLog" 
        ~: (False,"Smallish gang.Compared gang size to 9.")
        ~=? (3, "Smallish gang.") `applyLog` isBigGang,
    "Not just strings or lists but any monoid: Sum"
        ~: ("beer", Sum 65)
        ~=? ("beans", Sum 10) `applyLog` addDrink `applyLog` addDrink,
    "Writer - return"
        ~: ( (3,"")
           , (3, Product 1))
        ~=? ( runWriter (return 3 :: Writer String Int)
            , runWriter (return 3 :: Writer (Product Int) Int)),
    "Writer - >>="
        ~: (3,["Got number: 3"])
        ~=? runWriter (return 3 >>= logNumber),
    "Writer - do notation"
        ~: (15,["Got number: 3","Got number: 5", "Gonna multiply these numbers"])
        ~=? runWriter multWithLog
    ]

:}

runTestTT tests