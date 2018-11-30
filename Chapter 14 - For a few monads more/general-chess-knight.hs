import Test.HUnit
import Control.Monad(guard,(<=<))

:{

--Generalising the knight exercise from Chapter 13

type KnightPos = (Int,Int)

moveKnight :: KnightPos -> [KnightPos]
moveKnight (c,r) = do
    (c', r') <- [(c+2,r-1),(c+2,r+1),(c-2,r-1),(c-2,r+1),(c+1,r-2),(c+1,r+2),(c-1,r-2),(c-1,r+2)]
    guard (c' `elem` [1..8] && r' `elem` [1..8])
    return (c', r')

inX :: Int -> KnightPos -> [KnightPos]
inX x start = 
    --fold "monadic function composition" <=< over a list of moveKnight applications, using return as initial accumulator
    return start >>= foldr (<=<) return (replicate x moveKnight)
    
canReachIn :: Int -> KnightPos -> KnightPos -> Bool
canReachIn x start end = end `elem` inX x start

tests = test [ 
    "Three steps"
        ~: (True, False)
        ~=? ( canReachIn 3 (6,2) (6,1)
            , canReachIn 3 (6,2) (7,3))
    ]

:}

runTestTT tests