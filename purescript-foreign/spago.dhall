let lib = { dependencies = [ "prelude" ], sources = [ "src/**/*.purs" ] }

let test =
      { dependencies = [ "miraculix-lite" ], sources = [ "test/**/*.purs" ] }

in  { name = "purescript-foreign"
    , dependencies = lib.dependencies # test.dependencies
    , backend = "purenix"
    , packages = ./packages.dhall
    , sources = lib.sources # test.sources
    }
