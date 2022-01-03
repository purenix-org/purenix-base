module Test.Main where

import Prelude
import Test.Miraculix (TestTree, runTests, testGroup)
import Test.Foreign as Test.Foreign

main = runTests tests

tests :: TestTree
tests =
  testGroup "foreign"
    [ Test.Foreign.tests
    ]
