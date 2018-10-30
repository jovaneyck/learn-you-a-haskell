import Test.HUnit
import System.Random -- λ stack install random

:{

--custom random generator fun
data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
    deriving(Eq, Show, Enum)

instance Random Day where
    random gen = 
        let (r, next) = randomR (1,7) gen
            day = [Monday .. Sunday] !! r in
        (day, next)

    randomR (l,u) gen = undefined

tests = test [  
    "Get some random values with seeded generator" 
        ~: (7054720610510240562, 0.9313997)
        ~=? let seed = 1337
                generator = mkStdGen seed
                (randomInt,nextGenerator) = random generator :: (Int, StdGen) 
                (randomFloat,_) = random nextGenerator :: (Float, StdGen) in
            (randomInt, randomFloat),
    "Randoms of a custom type, entering property-based testing territory"
        ~: Tuesday
        ~=? let (r, _) = random (mkStdGen 1337) :: (Day, StdGen) in r,
    "Multiple randoms"
        ~: [7054720610510240562,7101563135667988245,-8322957909246309298]
        ~=? (take 3 $ randoms (mkStdGen 1337) :: [Int]),
    "Randoms in given ranges"
        ~: "xoqvebrryf"
        ~=? (take 10 $ randomRs ('a','z') (mkStdGen 1337))
        ]
:}

runTestTT tests