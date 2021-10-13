{ name = "purescript-type-equality"
, dependencies = [ ] : List Text
, backend = "purenix"
, packages = ./packages.dhall
, sources =
    [ "src/**/*.purs"
    -- , "test/**/*.purs"
    ]
}
