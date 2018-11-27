import Test.HUnit(runTestTT, test, (~:), (~=?)) --HUnit also exports State. As we're focusing on Control.Monad.State here, making that the default by explictly importing whatever we need from HUnit
import System.Random
import Control.Monad.State

:{

{-
newtype State s a = State { runState :: s -> (a, s) }

instance Monad (State s) where
    return x = State $ \s -> (x, s)
    (State h) >>= f = State $ \s -> 
        let (a, newState) = h s
            (State g) = f a
        in g newState
-}

threeCoinsExplicit :: StdGen -> (Bool, Bool, Bool)
threeCoinsExplicit gen =
    let (firstCoin, newGen) = random gen :: (Bool, StdGen)
        (secondCoin, newGen') = random newGen :: (Bool, StdGen)
        (thirdCoin, newGen'') = random newGen' :: (Bool, StdGen)
    in (firstCoin, secondCoin, thirdCoin)

randomSt :: (RandomGen g, Random a) => State g a
randomSt = state random
threeCoinsState :: State StdGen (Bool, Bool, Bool)
threeCoinsState = do
    a <- randomSt
    b <- randomSt
    c <- randomSt
    return (a, b, c)    

type Stack = [Int]
pop :: State Stack Int
pop = state $ \(x:xs) -> (x, xs)

push :: Int -> State Stack ()
push a = state $ \xs -> ((), a:xs)

{-
equivalent ot something like :

stackManip stack = let
    ((), newStack1) = push 3 stack
    (a , newStack2) = pop newStack1
    in pop newStack2
-}

stackManip :: State Stack Int
stackManip = do
    push 3
    a <- pop
    pop

stackyStack :: State Stack ()
stackyStack = do
    stackNow <- get --fetch the current state out of the context
    if stackNow == [1,2,3]
    then put [8,3,1] --overwrite the current context
    else put [9,2,1]


tests = test [ 
    "Explicit state passing" 
        ~: (True, False, False) 
        ~=? threeCoinsExplicit (mkStdGen 1337),
    "Implicit state passing using the State monad" 
        ~: (True, False, False) 
        ~=? (fst $ runState threeCoinsState (mkStdGen 1337)),
    "State - stack operations"
        ~: (1, [2,3])
        ~=? runState stackManip [1,2,3],
    "State - get and put"
        ~: ((),[8,3,1])
        ~=? runState stackyStack [1,2,3]
    ]

:}

runTestTT tests