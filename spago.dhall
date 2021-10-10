{ name = "either"

, dependencies =
    [ "control"
    , "invariant"
    , "maybe"
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
