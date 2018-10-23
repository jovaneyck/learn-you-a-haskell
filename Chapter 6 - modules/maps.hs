import Test.HUnit
import qualified Data.Map as Map

:{
    --constructing a map from a list
    m = Map.fromList $ [(3, "shoes"), (4,"trees")]

    tests = 
        test [
            "Looking up values in a map"
                ~: Just "shoes"
                ~=? Map.lookup 3 m,
            "Adding an entry to a map"
                ~: Just "games"
                ~=? let n = Map.insert 5 "games" m in
                    Map.lookup 5 n
        ]
:}

runTestTT tests