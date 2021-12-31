{ name = "purescript-nix-builtins-tests"
, dependencies =
    [ "maybe"
    , "prelude"
    , "tuples"
    , "unsafe-coerce"
    , "type-equality"
    , "miraculix"
    ]
, backend = "purenix"
, packages = ./packages.dhall
, sources =
    [ "src/**/*.purs"
    , "test/**/*.purs"
    ]
}
