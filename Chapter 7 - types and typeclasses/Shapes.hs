module Shapes
( Point(..) -- .. is shorthand for "expose all value constructors"
, Shape(..)
, area
) where

--define types with the data keyword
--sum types
data Point = Point Float Float
    deriving (Eq, Show) --ignore me for now, needed for tests
data Shape = Circle Point Float | Rectangle Point Point
    deriving (Show)

--pattern match on value constructors
area :: Shape -> Float
area (Circle _ r) = pi * r^2
area (Rectangle (Point x1 y1) (Point x2 y2)) =
    (abs $ x2 - x1) * (abs $ (y2 - y1))