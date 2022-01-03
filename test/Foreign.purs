module Test.Foreign where

import Prelude
import Foreign (Foreign)
import Foreign as F
import Test.Miraculix (TestTree, testCase, testGroup, (@?=))

tests :: TestTree
tests =
  testGroup "Foreign"
    []
