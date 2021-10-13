{ name = "purescript-orders"
, dependencies =
    [ "newtype", "prelude"
    ]
, backend = "purenix"
, packages = ./packages.dhall
, sources =
    [ "src/**/*.purs"
    -- , "test/**/*.purs"
    ]
}
