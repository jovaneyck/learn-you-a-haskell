--stack install HUnit via λ stack install HUnit
--stack ghci
-- execute a .hs file as a script: ":script unit-test-example"
import Test.HUnit

--running .hs as a script file does not allow for multi-line statements
--these :{ :} directives wrapped around function definitions allow for multiline
:{

    --verbose syntax
    tests = TestList [TestLabel "a test" (TestCase (assertEqual "Should be equal" (2 + 3) 5))]
    --runTestTT tests

    --terse syntax
    terseTests = 
        test [  "A test" ~: 5 ~=? (3 + 3), 
                "Another test" 
                    ~: 3 
                    ~=? 5
            ]

:}

runTestTT terseTests