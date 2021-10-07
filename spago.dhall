{ name = "prelude"

, dependencies =
    [ "unsafe-coerce"
    ]

, backend = "purenix"

, packages = ./packages.dhall

, sources =
    [ "src/**/*.purs"
    -- , "test/**/*.purs"
    ]
}
