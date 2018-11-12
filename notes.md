Notes
===

Monoids
---

```[haskell]
class Monoid m where
    mempty :: m
    mappend :: m -> m -> m
```

* An associative binary operation with a neutral element
* Examples
  * [] ++
  * 1 (*)
  * 0 (+)
  * True &&
  * False ||
  * ...

Functors
---

```[haskell]
fmap :: (Functor f) => (a -> b) -> f a -> f b
```

* A data type you can map functions over
* Examples: Maybe a, [a], IO a, (->)

Applicative Functors
---

```[haskell]
pure :: a -> f a

(<*>) :: (Applicative f) => f (a -> b) -> f a -> f b
```

* What if function is wrapped inside the data type?
* Enables applicative style: ` (*) <$> Just 2 <*> Just 8`
* Can be seen as a value with an added context (a "fancy" value)
  * Maybe : computations that might have failed
  * List: non-deterministic computations
  * IO: values with side-effects

Monads
---

```[haskell]
(>>=) :: (Monad m) => m a -> (a -> m b) -> m b
```

* We have a value with context and a function that takes a normal value and returns value with context. Enter: *bind*
* Examples: Maybe, List