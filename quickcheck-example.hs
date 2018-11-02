--stack install QuickCheck
import Test.QuickCheck

let prop_revRev xs = xs == reverse (reverse xs) --where types = xs :: [Int]
quickCheck prop_revRev

quickCheck (\ a b -> a + b == b + a)

--failure also shrinks:
--quickCheck (\a b -> a + b == 0)

--print out cases in case of infinite loop:
--verboseCheck (\ a b -> a + b == b + a)