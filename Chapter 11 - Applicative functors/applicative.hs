import Test.HUnit

:{

{-
    class (Functor f) => Applicative f where
    pure :: a -> f a
    (<*>) :: f (a -> b) -> f a -> f b
-}

tests = test [ 
    "Applicative list - pure" ~: [1] ~=? pure 1,
    "Applicative list - <*>" 
        ~:  ([4], [], [])
        ~=? ( pure (+1) <*> pure 3
            , []        <*> pure 3
            , pure (+1) <*> []),
    "Applicative Maybe - pure" ~: Just 3 ~=? pure 3,
    "Applicative Maybe - <*>" 
        ~:  (Just 4, Nothing, Nothing)
        ~=? ( pure (+1) <*> pure 3
            , Nothing   <*> pure 3
            , pure (+1) <*> Nothing),
    "Applicative style" 
        ~: Just 8
        ~=? pure (+) <*> Just 3 <*> Just 5,
    "<$> is an infix fmap"
        ~: Just 8
        ~=? (+) <$> Just 3 <*> Just 5,
    "<$> applicative style"
        ~: ["ha?","ha!","ha.","heh?","heh!","heh.","hmm?","hmm!","hmm."]
        ~=? (++) <$> ["ha", "heh", "hmm"] <*> ["?", "!", "."],
    "Applicative Function - pure"
        ~: 3
        ~=? let f = pure 3 in f "a random input",
    "Applicative Function - <*>"
        ~: (508, [8.0, 10.0, 2.5])
        ~=? ( ((+) <$> (+3) <*> (*100) $ 5)
            , ((\x y z -> [x,y,z]) <$> (+3) <*> (*2) <*> (/2) $ 5) )
    ]

:}

runTestTT tests