{ name = "invariant"

, dependencies =
    [ "control"
    , "prelude"
    ]

, backend = "purenix"

, packages = ./packages.dhall

, sources =
    [ "src/**/*.purs"
    -- , "test/**/*.purs"
    ]
}
