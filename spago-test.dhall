let lib = ./spago-lib.dhall

in  { name = "purescript-foreign-test"
    , dependencies = lib.dependencies # [ "miraculix-lite" ]
    , backend = lib.backend
    , packages = lib.packages
    , sources = lib.sources # [ "test/**/*.purs" ]
    }
