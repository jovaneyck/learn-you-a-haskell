import Test.HUnit
:{

    tests = 
        test [  "concatenation" ~: [1] ++ [2] ~=? [1,2],
                "strings are 'lists'" ~: head "ab" ~=? 'a',
                "cons" ~: 1 : [2,3] ~=? [1,2,3],
                "cons on strings" ~: 'A' : "BC" ~=? "ABC",
                "deconstructed" ~: 1 : 2 : 3 : [] ~=? [1,2,3],
                "indexing" ~: 6 ~=? [4,5,6] !! 2,
                "list comparison is structural" ~: [1,2,3] < [4,5,6] ~=? True,
                "head" ~: head [1,2,3] ~=? 1,
                "tail" ~: tail [1,2,3] ~=? [2,3],
                "last" ~: last [1,2,3] ~=? 3,
                "init" ~: init [1,2,3] ~=? [1,2],
                --"head can cause runtime exceptions" ~: head [] ~=? [],
                "null checks for empty" ~: null [] ~=? True,
                "reverse" ~: reverse [1,2,3] ~=? [3,2,1],
                "take" ~: take 2 [1,2,3] ~=? [1,2],
                "take on a short list" ~: take 10 [1,2,3] ~=? [1,2,3],
                "drop" ~: drop 2 [1,2,3] ~=? [3],
                "maximum" ~: maximum [1,3,2] ~=? 3,
                "sum" ~: sum [1,3,4] ~=? 8,
                "elem checks for contains" ~: elem 3 [1,2,3] ~=? True,
                "ranges" ~: [1..5] ~=? [1,2,3,4,5],
                "ranges with step sizes" ~: [1,3..10] ~=? [1,3,5,7,9],
                "descending ranges" ~: [5,4..1] ~=? [5,4,3,2,1], --5..1 does not work
                "infinite lists" ~: take 4 [1,2..] ~=? [1,2,3,4],
                "infinite lists with cycle" ~: take 4 (cycle [1,2]) ~=? [1,2,1,2],
                "infinite lists with repeat" ~: take 3 (repeat 1) ~=? [1,1,1],
                "replicate an item N times" ~: replicate 3 "A" ~=? ["A", "A", "A"],
                "list comprehensions" 
                    ~: [2,4,6] ~=? [x*2 | x <- [1..3]],
                "list comprehensions with filter"
                    ~: [6] ~=? [3*x | x <- [1..3], x `mod` 2 == 0],
                "nontrivial list comprehension"
                    ~: ["BOOM!", "BOOM!", "BANG!", "BANG!"]
                    ~=? [if x < 10 then "BOOM!" else "BANG!" | x <- [7..13], odd x],
                "list comprehension with multiple filter predicates"
                    ~: [10,11,12,14,16,17,18,20] 
                    ~=? [x | x <- [10..20], x /= 13, x /= 15, x /= 19],
                "list comprehension multiple"
                    ~: [11, 101, 1001,12,102,1002,13,103,1003]
                    ~=? [x + y | x <- [1,2,3], y <- [10, 100, 1000]],
                "length as list comprehension"
                    ~:
                        let length' xs = sum [1 | _ <- xs] in
                        3 ~=? length' [1,2,3],
                "list comprehension - strings are lists too"
                    ~: let removeNonUppercase s = [c | c <- s, elem c ['A'..'Z']] in
                        "ILIKEFROGS" ~=? removeNonUppercase "IdontLIKEFROGS",
                "list comprehension - nesting"
                    ~: let xxs = [[1,2,3], [4,5,6]] in
                        [[2],[4,6]]
                        ~=? [ [x | x <- xs, even x] | xs <- xxs]
            ]

:}

runTestTT tests