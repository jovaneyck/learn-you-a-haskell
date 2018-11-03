import Test.HUnit
import Control.Applicative

:{

--ZipList: another Applicative functor instance for Lists:
{-
    instance Applicative ZipList where
    pure x = ZipList (repeat x)
    ZipList fs <*> ZipList xs = ZipList (zipWith (\f x -> f x) fs xs)
-}

tests = test [ 
    "Ziplist pure" 
        ~: [3,3,3,3,3]
        ~=? (take 5 $ getZipList $ pure 3),
    "ZipList applicative style"
        ~: [5,3,3,4]
        ~=? (getZipList $ max <$> ZipList [1,2,3,4,5,3] <*> ZipList [5,3,1,2])
    ]

:}

runTestTT tests