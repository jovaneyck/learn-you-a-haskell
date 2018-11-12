import Test.HUnit

:{

type Birds = Int
type Pole = (Birds, Birds)

landLeft :: Birds -> Pole -> Maybe Pole
landLeft n (left, right)
    | abs ((left + n) - right) < 4 = Just (left + n, right)
    | otherwise = Nothing

landRight :: Birds -> Pole -> Maybe Pole
landRight n (left, right)
    | abs (left - (right + n)) < 4 = Just (left, right + n)
    | otherwise = Nothing


--F# pipe, -: makes me uncomfortable and reminds me of Prolog :P
x |> f = f x

banana :: Pole -> Maybe Pole
banana _ = Nothing --always fail

tests = test [ 
    "landLeftRight" 
        ~: (Just (1,0),Just (0,1)) 
         ~=? (landLeft 1 (0,0), landRight 1 (0,0)),
    "repeatedly land with bind"
        ~: Just (3,1)
        ~=? (return (0,0) >>= landLeft 1 >>= landRight 1 >>= landLeft 2),
    "repeatedly land with an imbalance thrown in"
        ~: Nothing
        ~=? (return (0, 0) 
                >>= landLeft 1 
                >>= landRight 4 
                >>= landLeft (-1) --uh oh
                >>= landRight (-2)),
    "banana"
        ~: Nothing
        ~=? (return (0, 0) >>= landLeft 1 >>= banana >>= landRight 1),
    "using do notation"
        ~: Just (3,2)
        ~=? do
                start <- return (0,0)
                first <- landLeft 2 start
                second <- landRight 2 first
                landLeft 1 second
    ]

:}

runTestTT tests