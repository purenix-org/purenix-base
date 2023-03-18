module Test.Main where

import Test.MiraculixLite (TestTree, runTests, testGroup)
import Test.Data.Enum as Test.Data.Enum

main = runTests tests

tests :: TestTree
tests =
  testGroup "enums"
    [ Test.Data.Enum.tests
    ]
