module Control.Monad.ST.Global
  ( Global
  ) where

import Prelude

import Control.Monad.ST (ST, Region)
import Unsafe.Coerce (unsafeCoerce)

-- | This region allows `ST` computations to be converted into `Effect`
-- | computations so they can be run in a global context.
foreign import data Global :: Region
