let upstream =
      https://raw.githubusercontent.com/purenix-org/temp-package-set/main/packages.dhall sha256:35a43b497d0e850f2ea201726d267132b1e66149d7f80d43a64fc8318ca783b9

let additions = {
  miraculix =
  { dependencies =
    [ "prelude"
    , "foldable-traversable"
    , "newtype"
    ]
  , repo = "https://github.com/thought2/purescript-miraculix.git"
  , version = "v0.1.0"
  }
}

in  upstream // additions