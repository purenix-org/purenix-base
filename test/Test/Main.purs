module Test.Main where

import Prelude
import Data.Maybe (Maybe(..))
import Data.Tuple.Nested ((/\))
import Test.Miraculix (StorePath, TestTree, runTests, testCase, testGroup, (@?=))
import Nix.Builtins as B
import Type.Proxy (Proxy(..))

main :: StorePath
main = runTests tests

tests :: TestTree
tests =
  testGroup "Effect"
    []
