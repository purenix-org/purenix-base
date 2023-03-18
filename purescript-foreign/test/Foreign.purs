module Test.Foreign where

import Prelude
import Foreign (Foreign)
import Foreign as F
import Test.MiraculixLite (TestTree, testCase, testGroup, (@?=))

-- Remove once https://github.com/purenix-org/purenix/issues/35 is fixed
foreign import tick :: String

foreign import eval :: String -> Foreign

tests :: TestTree
tests =
  testGroup "Foreign"
    [ testGroup "predicates"
        [ testGroup "isAttrs"
            [ testCase "empty attr set" $ (F.isAttrs $ eval "{}") @?= true
            , testCase "non empty attr seyt"
                $ (F.isAttrs $ eval "{ foo = 0; bar = true; }")
                @?= true
            , testCase "failing case" $ (F.isAttrs $ eval "1") @?= false
            ]
        , testGroup "isBool"
            [ testCase "true" $ (F.isBool $ eval "true") @?= true
            , testCase "false" $ (F.isBool $ eval "false") @?= true
            , testCase "failing case" $ (F.isBool $ eval "1") @?= false
            ]
        , testGroup "isPath"
            [ testCase "relative dir" $ (F.isPath $ eval "./foo/bar") @?= true
            , testCase "current dir" $ (F.isPath $ eval "./.") @?= true
            , testCase "relative file" $ (F.isPath $ eval "./foo/bar.txt") @?= true
            , testCase "absolute dir" $ (F.isPath $ eval "/foo/bar") @?= true
            , testCase "parent dir" $ (F.isPath $ eval "./..") @?= true
            , testCase "middle parent dir" $ (F.isPath $ eval "./foo/../bar") @?= true
            , testCase "without leading indicator" $ (F.isPath $ eval "foo/bar") @?= true
            , testCase "failing case" $ (F.isPath $ eval "null") @?= false
            ]
        , testGroup "isFloat"
            [ testCase "positive float" $ (F.isFloat $ eval "1.5") @?= true
            , testCase "negative float" $ (F.isFloat $ eval "-1.5") @?= true
            , testCase "int as float" $ (F.isFloat $ eval "1.0") @?= true
            , testCase "int" $ (F.isFloat $ eval "1") @?= false
            ]
        , testGroup "isFunction"
            [ testCase "one arg" $ (F.isFunction $ eval "x : x + 1") @?= true
            , testCase "two args" $ (F.isFunction $ eval "x : y:  x + y") @?= true
            , testCase "failing case" $ (F.isFunction $ eval "1") @?= false
            ]
        , testGroup "isInt"
            [ testCase "positive int" $ (F.isInt $ eval "1") @?= true
            , testCase "negative int" $ (F.isInt $ eval "-1") @?= true
            , testCase "float" $ (F.isInt $ eval "1.0") @?= false
            ]
        , testGroup "isList"
            [ testCase "empty" $ (F.isList $ eval "[]") @?= true
            , testCase "non empty" $ (F.isList $ eval "[ 1 2 3 ]") @?= true
            , testCase "non empty, heterogenous" $ (F.isList $ eval "[ 1 2 true ]") @?= true
            , testCase "failing case" $ (F.isList $ eval "1") @?= false
            ]
        , testGroup "isNull"
            [ testCase "null" $ (F.isNull $ eval "null") @?= true
            , testCase "0" $ (F.isNull $ eval "0") @?= false
            ]
        , testGroup "isString"
            [ testCase "empty" $ (F.isString $ eval "''''") @?= true
            , testCase "non empty" $ (F.isString $ eval "''foo''") @?= true
            , testCase "failing case" $ (F.isString $ eval "1") @?= false
            ]
        ]
    ]
