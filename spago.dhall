{ name = "newtype"

, dependencies =
    [ "prelude"
    , "safe-coerce"
    ]

, backend = "purenix"

, packages = ./packages.dhall

, sources =
    [ "src/**/*.purs"
    -- , "test/**/*.purs"
    ]
}
