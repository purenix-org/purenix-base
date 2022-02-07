module Test.Main where

import Test.MiraculixLite (TestTree, runTests, testGroup)
import Test.Test.Assert as Test.Test.Assert

main = runTests tests

tests :: TestTree
tests =
  testGroup "assert"
    [ Test.Test.Assert.tests
    ]
