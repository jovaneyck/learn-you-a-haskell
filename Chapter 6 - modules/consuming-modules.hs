import Data.List --import everything
import Data.List(nub) --only import listed
import Data.List hiding (nub) --exclude certain things we might define
import Data.List
import qualified Data.Map as Map --must include qualifier to use

import Geometry.Cube

--GHCi: 
-- :m Data.List to import
-- :m + Data.List to add a new import to currently imported modules