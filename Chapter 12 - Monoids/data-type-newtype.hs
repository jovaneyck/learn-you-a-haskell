import Test.HUnit

:{

--type defines a synonym/alias, original and synonym can be used interchangeably
type IntList = [Int]

--newtype wraps an existing type (single value ctor), 
--used to e.g. implement a typeclass "multiple times" (List & ZipList)
newtype CharList = CharList { getCharList :: [Char] } deriving(Show,Eq)

newtype CoolBool = CoolBool {getBool :: Bool}

--data declares new algebraic data types
data Maybe a = Nope | Yep a --sum
data Person = Person { getName :: String, getAge :: Int } --product

tests = test [ 
    "type is used for type aliases/synonyms" 
        --can mix/match [Int] and IntList, no difference to typechecker
        ~: ([1,2] :: IntList) 
        ~=? ([1] :: IntList) ++ ([2] :: [Int]),
    "newtype - creating an instance"
        ~: CharList "hello"
        ~=? CharList "hello",
    "newtype - getting the wrapped type"
        ~: "hmm"
        ~=? (getCharList $ CharList "hmm"),
    "newtype - is super lazy"
        ~: "hello"
        ~=? let helloMe (CoolBool _) = "hello" in
                helloMe undefined --this would blow up very hard if CoolBool was declared using data
    ]

:}

runTestTT tests