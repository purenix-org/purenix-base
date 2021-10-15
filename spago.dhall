{ name = "purescript-unfoldable"
, dependencies =
    [ "foldable-traversable"
    , "maybe"
    , "partial"
    , "prelude"
    , "tuples"
    ]
, backend = "purenix"
, packages = ./packages.dhall
, sources =
    [ "src/**/*.purs"
    -- , "test/**/*.purs"
    ]
}
