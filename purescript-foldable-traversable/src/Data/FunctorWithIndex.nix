

{ # (i -> a -> b) -> Array a -> Array b
  #
  # This is the imap0 function from nixpkgs/lib/lists.nix.
  mapWithIndexArray = f: xs:
    builtins.genList (n: f n (builtins.elemAt xs n)) (builtins.length xs);
}
