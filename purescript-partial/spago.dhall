{ name = "purescript-partial"
, dependencies = [ ] : List Text
, backend = "purenix"
, packages = ./packages.dhall
, sources =
    [ "src/**/*.purs"
    -- , "test/**/*.purs"
    ]
}
