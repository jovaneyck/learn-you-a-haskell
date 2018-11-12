import Test.HUnit
import Control.Monad(guard)

:{

{-
class Applicative m => Monad (m :: * -> *) where
  (>>=) :: m a -> (a -> m b) -> m b --BIND
  (>>) :: m a -> m b -> m b
  return :: a -> m a -- "pure" from Applicative
  fail :: String -> m a

  m >> n = m >>= \_ -> n --always return n but use "bind" to act on the **context** of input m

instance Monad [] where
  return x = [x]
  xs >>= f = concat (map f xs)
  fail _ = []

class Monad m => MonadPlus m where
  mzero :: m a
  mplus :: m a -> m a -> m a

instance MonadPlus [] where
  mzero = []
  mplus = (++)

guard :: (MonadPlus m) => Bool -> m ()
guard True = return () --return unit in a "minimal context", i.e. "success case"
guard False = mzero
-}


applyMaybe :: Maybe a -> (a -> Maybe b) -> Maybe b
applyMaybe Nothing _ = Nothing
applyMaybe (Just x) f = f x

tests = test [ 
    "applyMaybe" 
        ~: (Just 6 , Nothing, Nothing)
        ~=? 
           ( Just 2  `applyMaybe` (\x -> Just $ x * 3)
           , Nothing `applyMaybe` (\x -> Just $ x * 3)
           , Just 2  `applyMaybe` (\x -> Nothing)),
    "Maybe -return" ~: Just 1 ~=? return 1,
    "Maybe - bind"
        ~:  ( Just 6, Nothing, Nothing)
        ~=? ( Just 2  >>= (\x -> return $ x * 3)
            , Nothing >>= (\x -> return $ x * 3)
            , Just 2  >>= (\x -> Nothing)),
    ">>"
        ~:  ( Nothing
            , Just 4
            , Nothing)
        ~=? ( (Nothing >> Just 3) --m is Nothing, so short-circuit
            , Just 3 >> Just 4 --m is Just, so return n
            , Just 3 >> Nothing), --m is Just, so return n
    "fail: handle pattern match issues in monadic context more elegantly"
        --Maybe.fail _ = Nothing, maybe has a representation of "a problem" with Nothing
        ~: Nothing
        ~=? do
                x:xs <- Just "" --this blows up, instead of an error Maybe.fail gets called
                return x,
    "List - return" ~: [1] ~=? return 1,
    "List - bind"
        ~:  ( [1,-1,2,-2,3,-3]
            , []
            , [(1,'a'),(1,'b'),(2,'a'),(2,'b')])
        ~=? ( ([1..3] >>= (\x -> [x,-x]))
            , ([] >>= (\x -> [1..3]))
            , ([1,2] >>= \x -> ['a','b'] >>= \y -> return (x,y) )),
    "List - do notation is quasi equivalent to list comprehensions!"
        ~: [(1,'a'),(1,'b'),(2,'a'),(2,'b')]
        ~=? do
                x <- [1..2]
                y <- ['a'..'b']
                return (x,y),
    "MonadPlus - guard for maybe"
            ~: (Just (), Nothing)
            ~=? ( guard (5>2) :: Maybe ()
                , guard (5<2) :: Maybe ()),
    "guard for []"
            ~: ([()], [])
            ~=? ( guard (5>2) :: [()]
                , guard (5<2) :: [()]),
    "guard in conjunction with >>"
        ~: ( ["cool"]
           , [])
        ~=? ( (guard (5 > 2) >> return "cool" :: [String])
            , (guard (5 < 2) >> return "cool" :: [String])),
    "guard and >> work as a filter"
        ~: [7,17,27,37,47]
        ~=? ([1..50] >>= (\x -> guard ('7' `elem` show x) >> return x)),
    "guard in do notation"
        ~:  [7,17,27,37,47]
        ~=? do
                x <- [1..50]
                guard ('7' `elem` show x)
                return x

    ]

:}

runTestTT tests