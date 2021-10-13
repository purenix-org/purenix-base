{ name = "purescript-identity"
, dependencies =
    [ "control"
    , "invariant"
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
