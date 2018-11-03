main = do
    l <- (++) <$> getLine <*> getLine
    putStrLn l