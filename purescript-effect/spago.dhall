{ name = "purescript-effect"
, dependencies =
    [ "prelude"
    ]
, backend = "purenix"
, packages = ./packages.dhall
, sources =
    [ "src/**/*.purs"
    ]
}
