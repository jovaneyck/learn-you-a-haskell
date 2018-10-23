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
    tests = 
        test [  
            "automagically implement == by deriving Eq" 
                ~: MyValueConstructor
                ~=? MyValueConstructor,
            "Enum allows you to iterate over value constructors"
                ~: [Monday,Tuesday,Wednesday,Thursday,Friday]
                ~=? [Monday .. Friday]
            ]

:}

runTestTT tests