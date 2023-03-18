{ name = "purescript-distributive"
, dependencies =
    [ "identity"
    , "newtype"
    , "prelude"
    , "tuples"
    , "type-equality"
    ]
, backend = "purenix"
, packages = ./packages.dhall
, sources =
    [ "src/**/*.purs"
    -- , "test/**/*.purs"
    ]
}
