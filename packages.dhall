let upstream =
      https://raw.githubusercontent.com/purenix-org/temp-package-set/main/packages.dhall sha256:c073e77508fdfeaba77c854190335a1214cb67b57db1b641b14b54427e83ed0c

let additions =
      { miraculix-lite =
        { dependencies = [ "prelude", "newtype", "orders" ]
        , repo = "https://github.com/thought2/purescript-miraculix.git"
        , version = "lite"
        }
      }

in  upstream // additions
