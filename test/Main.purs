module Test.Main where

import Prelude
import Test.MiraculixLite (TestTree, runTests, testGroup)
import Test.Foreign as Test.Foreign

main = runTests tests

tests :: TestTree
tests =
  testGroup "foreign"
    [ Test.Foreign.tests
    ]
