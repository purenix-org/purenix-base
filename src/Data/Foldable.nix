
{ # This is foldr from nixpkgs/lib/lists.nix
  foldrArray = op: nul: list:
    let
      len = builtins.length list;
      fold' = n:
        if n == len
        then nul
        else op (builtins.elemAt list n) (fold' (n + 1));
    in fold' 0;

  foldlArray = builtins.foldl';
}
