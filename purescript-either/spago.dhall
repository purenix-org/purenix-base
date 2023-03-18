{ name = "either"

, dependencies =
    [ "control"
    , "invariant"
    , "maybe"
    , "prelude"
    ]

, backend = "purenix"

, packages = ./packages.dhall

, sources =
    [ "src/**/*.purs"
    -- , "test/**/*.purs"
    ]
}
