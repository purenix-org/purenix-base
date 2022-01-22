{ name = "purescript-foreign"
, dependencies = [] : List Text
, backend = "purenix"
, packages = ./packages.dhall
, sources = [ "src/**/*.purs" ]
}
