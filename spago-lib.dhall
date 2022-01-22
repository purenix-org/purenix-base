{ name = "purescript-foreign"
, dependencies = [ "prelude" ]
, backend = "purenix"
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
