{ name = "purescript-const"
, dependencies =
    [ "invariant"
    , "newtype"
    , "prelude"
    ]
, backend = "purenix"
, packages = ./packages.dhall
, sources =
    [ "src/**/*.purs"
    -- , "test/**/*.purs"
    ]
}
