import Test.HUnit
:l Roadtrip.hs

:{

heathrowToLondon :: Roadtrip.RoadSystem
heathrowToLondon =  [ Section 50 10 30
                    , Section 5 90 20
                    , Section 40 2 25
                    , Section 10 8 0
                    ]
tests = test [  
    "Optimal path" 
        ~: [(B,10),(C,30),(A,5),(C,20),(B,2),(B,8),(C,0)]
        ~=? Roadtrip.optimalPath heathrowToLondon
    ]
:}

runTestTT tests