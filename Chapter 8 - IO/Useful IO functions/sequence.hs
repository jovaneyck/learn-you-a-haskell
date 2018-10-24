main = do
    inputs <- sequence [getLine, getLine]
    print inputs -- prints out ["a", "b"]

    sequence $ map print [1..5]
    --prints out 1\n2\n3\n4\n5