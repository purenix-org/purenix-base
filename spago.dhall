let lib =
      { dependencies =
        [ "control"
        , "either"
        , "maybe"
        , "newtype"
        , "nonempty"
        , "partial"
        , "prelude"
        , "tuples"
        , "unfoldable"
        ]
      , sources = [ "src/**/*.purs" ]
      }

let test =
      { dependencies = [ "miraculix-lite" ], sources = [ "test/**/*.purs" ] }

in  { name = "purescript-enums"
    , dependencies = lib.dependencies # test.dependencies
    , backend = "purenix"
    , packages = ./packages.dhall
    , sources = lib.sources # test.sources
    }
