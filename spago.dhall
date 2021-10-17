{ name = "purescript-st"
, dependencies =
    [ "partial"
    , "prelude"
    -- , "unsafe-coerce"
    ]
, backend = "purenix"
, packages = ./packages.dhall
, sources =
    [ "src/**/*.purs"
    -- , "test/**/*.purs"
    ]
}
