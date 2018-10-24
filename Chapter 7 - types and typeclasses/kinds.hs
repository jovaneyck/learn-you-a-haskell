--Kinds are "labels on types", just as types are "labels on values"
:k Int
-- Int :: * -- * means: "concrete type"

:k Maybe
-- Maybe :: * -> * means: type constructor that takes a concrete type and returns a concrete type

:k Either --Either :: * -> * -> *
:k Either String --Either String :: * -> *
:k Either String Int --Either String Int :: *

-- You sometimes need to know this, e.g:
:info Functor
{- 
class Functor (f :: * -> *) where
    fmap :: (a -> b) -> f a -> f b
-}