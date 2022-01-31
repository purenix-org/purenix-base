let upstream =
      https://raw.githubusercontent.com/purenix-org/temp-package-set/main/packages.dhall sha256:32624b49386058000cc7cd831cad251d91a4d7b9174040214bbb16b7e79ee1f9

let additions =
      { miraculix-lite =
        { dependencies = [ "prelude", "newtype", "orders" ]
        , repo = "https://github.com/thought2/purescript-miraculix.git"
        , version = "lite"
        }
      }

in  upstream // additions
