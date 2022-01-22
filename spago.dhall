let lib = ./spago-lib.dhall

let test = ./spago-test.dhall

in  { name = "purescript-foreign-dev"
    , dependencies = lib.dependencies # test.dependencies
    , backend = lib.backend
    , packages = lib.packages
    , sources = lib.sources # test.sources
    }
