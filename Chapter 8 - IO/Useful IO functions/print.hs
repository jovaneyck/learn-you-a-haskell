data TrafficLight = Red | Yellow | Green
instance Show TrafficLight where
    show Green = "Green light"

main = do
    -- putStrLn Green --type error: Green is not a String
    print Green --calls show and outputs