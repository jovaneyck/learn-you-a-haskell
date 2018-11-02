--compile: stack ghc helloworld.hs
--just run: stack runhaskell helloworld.hs
--IO actions are only ever executed in context of a function called "main"
main :: IO () -- for illustration purpose, main is usually never typed
main =
    putStrLn "Hello world!"