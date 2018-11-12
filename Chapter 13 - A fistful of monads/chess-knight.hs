import Test.HUnit
import Control.Monad(guard)

:{

type KnightPos = (Int,Int)

{-
    non-monadic:
    moveKnight :: KnightPos -> [KnightPos]
    moveKnight (c, r) = 
        filter onBoard [(c+2,r-1),(c+2,r+1),(c-2,r-1),(c-2,r+1),(c+1,r-2),(c+1,r+2),(c-1,r-2),(c-1,r+2)]
        where onBoard (c, r) = c `elem` [1..8] && r `elem` [1..8]
-}

moveKnight :: KnightPos -> [KnightPos]
moveKnight (c,r) = do
    (c', r') <- [(c+2,r-1),(c+2,r+1),(c-2,r-1),(c-2,r+1),(c+1,r-2),(c+1,r+2),(c-1,r-2),(c-1,r+2)]
    guard (c' `elem` [1..8] && r' `elem` [1..8])
    return (c', r')

in3 :: KnightPos -> [KnightPos]
in3 start = return start >>= moveKnight >>= moveKnight >>= moveKnight

canReachIn3 :: KnightPos -> KnightPos -> Bool
canReachIn3 start end = end `elem`in3 start

tests = test [ 
    "Let's move a knight once" 
        ~: [(6,3),(6,5),(2,3),(2,5),(5,2),(5,6),(3,2),(3,6)] 
        ~=? moveKnight (4,4),
    "Three steps"
        ~: (True, False)
        ~=? ( (6,2) `canReachIn3` (6,1)
            , (6,2) `canReachIn3` (7,3))
    ]

:}

runTestTT tests