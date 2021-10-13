{ name = "purescript-functors"
, dependencies =
    [ "bifunctors"
    , "const"
    , "contravariant"
    , "control"
    , "distributive"
    , "either"
    , "invariant"
    , "maybe"
    , "newtype"
    , "prelude"
    , "profunctor"
    , "tuples"
    , "unsafe-coerce"
    ]
, backend = "purenix"
, packages = ./packages.dhall
, sources =
    [ "src/**/*.purs"
    -- , "test/**/*.purs"
    ]
}
