import Test.HUnit
import Shapes
import qualified Data.Map as Map

:{

-- sum types in Shapes.hs
--record types:
data Person = Person { firstName :: String
                     , lastName :: String }
                     deriving (Show)

--automagically generates functions firstName and lastName that take a Person
-- this will not compile: data What = What {firstName :: String}

--type parameters
data MyMaybe a = Nikske | Gewoon a
-- MyMaybe = _type_ constructor because it takes an a and returns a type
-- Just = _value_ constructor

--Haskell idiom: Never put type constraints in data definitions, only in function typedefs
data Vector a = Vector a a a deriving (Show, Eq)
vplus :: (Num a) => Vector a -> Vector a -> Vector a
(Vector i j k) `vplus` (Vector l m n) = Vector (i+l) (j+m) (k+n)

--Type synonyms: you can alias types
type PhoneNumber = String

--Either
data Either a b = Left a | Right b deriving (Eq, Ord, Read, Show)
data LockerState = Taken | Free deriving (Show, Eq)
type Code = String
type LockerMap = Map.Map Int (LockerState, Code)
lockerLookup :: Int -> LockerMap -> Either String Code --Right is always success case, Left is error case!!
lockerLookup lockerNb map =
    case Map.lookup lockerNb map of
        Nothing -> Left $ "Locker" ++ show lockerNb ++ " does not exist!"
        Just (state, code) -> if state /= Taken
                              then Right code
                              else Left $ "Locker " ++ show lockerNb ++ " is already taken!"

lockers :: LockerMap
lockers =
    Map.fromList
        [(100,(Taken, "ZD39I"))
        ,(101,(Free, "JAH3I"))
        ,(103,(Free, "IQSA9"))
        ,(105,(Free, "QOTSA"))
        ,(109,(Taken, "893JJ"))
        ,(110,(Taken, "99292"))
        ]                          

tests = 
    test [  
        "A value constructor is just a function" 
            ~: Point 0 4
            ~=? let onX = (Point 0) in onX 4,
        "Pattern matching on value constructors works as expected"
            ~: 13.854422
            ~=? area (Circle (Point 3 4) 2.1),
        "record types"
            ~: "Van Eyck"
            ~=? let me = Person "Jo" "Van Eyck" in lastName me,
        "type parameters"
            ~: Vector 3 4 5
            ~=? Vector 1 2 3 `vplus` Vector 2 2 2,
        "either - success"
            ~: Right "JAH3I"
            ~=? lockerLookup 101 lockers,
        "either - failure"
            ~: Left "Locker 100 is already taken!"
            ~=? lockerLookup 100 lockers
    ]
:}

runTestTT tests