import Test.HUnit
:{

--implementing a typeclass automagically with deriving:
data MyType = MyValueConstructor deriving (Show, Eq)

data Day = Monday | Tuesday | Wednesday | Thursday | Friday | Saturday | Sunday
    deriving(
        Eq,  -- ==
        Ord, -- compare
        Show, -- toString 
        Read, -- parse
        Bounded, --minBound maxBound
        Enum) -- ranges

-- Creating my own typeclasses
class MyEq a where
    (==) :: a -> a -> Bool
    (/=) :: a -> a -> Bool

    --mutually recursive functions, only have to implement one in instances and get the other one for free
    --"minimal complete definition"
    x == y = not (x /= y)
    x /= y = not (x == y)

data TrafficLight = Red | Yellow | Green

--custom derives for a typeclass
instance MyEq TrafficLight where
    Red == Red = True
    Green == Green = True
    Yellow == Yellow = True
    _ == _ = False

instance Show TrafficLight where
    show Red = "Red light"
    show Yellow = "Yellow light"
    show Green = "Green light"

class Truthy a where
    truthy :: a -> Bool

instance Truthy Int where
    truthy 0 = False
    truthy _ = True
instance Truthy [a] where
    truthy [] = False
    truthy _ = True
instance Truthy Bool where
    truthy = id

truthyIf :: (Truthy p) => p -> a -> a -> a
truthyIf p ifBranch elseBranch =
    if truthy p then ifBranch else elseBranch

--Functor type class
--class Functor f where
--    fmap :: (a -> b) -> f a -> f b
-- f is in the TYPE DECLARATION, f is a TYPE CONSTRUCTOR (<> value constructor)
-- Example type constructor: Maybe (NOT Maybe a):
--instance Functor Maybe where
--    fmap f (Just x) = Just $ f x
--    fmap _  Nothing = Nothing

tests = 
    test [  
        "automagically implement == by deriving Eq" 
            ~: MyValueConstructor
            ~=? MyValueConstructor,
        "Enum allows you to iterate over value constructors"
            ~: [Monday,Tuesday,Wednesday,Thursday,Friday]
            ~=? [Monday .. Friday],
        "Defining and implementing my own Eq typeclass"
            ~: False
            ~=? Red == Green,
        "Custom derive of Show"
            ~: "Green light"
            ~=? show Green,
        "Truthy typeclass"
            ~: (True, False)
            ~=? (truthyIf [1] True False, truthyIf (0::Int) True False)
        ]

:}

runTestTT tests